#!/bin/bash

# Define the name of the database to be used. Note that the first postgres
# commands will drop and recreate this database.
database="cluster_analysis"

# Set up an empty database with the name above.
# Drop the existing database if it exists.
if psql $database -c '\q' 2>&1; then
	sudo -u $USER dropdb --if-exists $database
	sudo -u $USER createdb $database
	echo "$database dropped and recreated."
else
	sudo -u $USER createdb $database
	echo "$database created."
fi

# Create the table in the database to hold the LibraryThing dump file's data.
psql $database -f create_table.sql > /dev/null 2>&1

# Status update.
echo "public.library created in $database."

# Load the LibraryThing dump file (converted to CSV) into the database and
# record the number of rows imported.
n_records_loaded=$(psql $database -f load_table.sql)

# Scrub the output of the postgres command to just the number of rows loaded.
n_records_loaded=${n_records_loaded//[a-zA-Z ]/}

# Status update.
echo "${n_records_loaded} records from LibraryThing dump file loaded into public.library."

# Clean up the height into a standard format and Imperial units and record the
# number of non-NULL values that are produced.
psql $database -f clean_and_convert_height.sql > /dev/null 2>&1
n_height_non_null=$(psql $database -t -c "SELECT COUNT(*) FROM library WHERE height_scrubbed IS NOT NULL")

# Trim whitespace.
n_height_non_null=${n_height_non_null// /}

# Status update.
echo "$n_height_non_null heights converted into numeric, Imperial values."

# Clean up the length into a standard format and Imperial units and record the
# number of non-NULL values that are produced.
psql $database -f clean_and_convert_length.sql > /dev/null 2>&1
n_length_non_null=$(psql $database -t -c "SELECT COUNT(*) FROM library WHERE length_scrubbed IS NOT NULL")

# Trim whitespace.
n_length_non_null=${n_length_non_null// /}

# Status update.
echo "$n_length_non_null lengths (depths) converted into numeric, Imperial values."

# Clean up the thickness into a standard format and Imperial units and record
# the number of non-NULL values that are produced.
psql $database -f clean_and_convert_thickness.sql > /dev/null 2>&1
n_thickness_non_null=$(psql $database -t -c "SELECT COUNT(*) FROM library WHERE thickness_scrubbed IS NOT NULL")

# Trim whitespace.
n_thickness_non_null=${n_thickness_non_null// /}

# Status update.
echo "$n_thickness_non_null thicknesses converted into numeric, Imperial values."

# Standardize the dimensions to have either all or none for each record.
psql $database -f standardize_dimensions.sql > /dev/null 2>&1
echo "Dimensions standardized to all or nothing (height-length-thickness)."

# Record how many records have all of their dimensions, no dimensions.
n_dimensions=$(psql $database -t -c "SELECT COUNT(*) FROM library WHERE thickness_scrubbed IS NOT NULL")
n_no_dimensions=$(psql $database -t -c "SELECT COUNT(*) FROM library WHERE thickness_scrubbed IS NULL")

# Trim whitespace.
n_dimensions=${n_dimensions// /}
n_no_dimensions=${n_no_dimensions// /}

# Status update.
echo "${n_dimensions} records with height/length/thickness, ${n_no_dimensions} records without."

# Clear out the working file directory if it exists.
[ -d working ] && { rm -rf working; echo "Existing /working directory removed."; }

# Create the /plots directory.
mkdir working

# Allow _all_ users write access. Note that this is not optimum, but I've not
# taken the time to find the postgres-specific setting.
chmod a+w ./working

# Status update.
echo "Created /working directory."

# Output raw data with book dimensions and record the number of rows imported.
n_records_dumped=$(psql $database -f output_dimensions.sql)

# Scrub the output of the postgres command to just the number of rows dumped.
n_records_dumped=${n_records_dumped//[a-zA-Z ]/}

# Status update.
echo "${n_records_dumped} records from public.library with dimensions dumped for plotting."

# Get ready to output first-pass summary plots.
# Clear out the /plots directory (if it exists).
[ -d plots ] && { rm -rf plots; echo "Existing /plots directory removed."; }

# Create the /plots directory.
mkdir plots

# Status update.
echo "Created /plots directory."
