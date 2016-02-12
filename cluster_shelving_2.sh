#!/bin/bash

# Define the directory location of the script.
DIR=$(dirname "$(readlink -f "$0")")

# Define the name of the database to be used.
database="cluster_analysis"

# Define the settings for the summary histograms.
n_intervals=100

# Newline to set off script output.
echo

# Create the table public.library_clusters and load in the R cluster file.
source ./subscripts/load_clusters.sh

# Add the clusters to the main library table.
psql $database -f ${DIR}/subscripts/sql/add_clusters.sql > /dev/null 2>&1







# Summarize each cluster - the same statistics as before, but including the
# total thickness (shelf-length) of the cluster.

# Output the dimensional data for each cluster.

# Plot the histograms and heat maps for each cluster.

# Clean things up and zip output folders for convenience.
