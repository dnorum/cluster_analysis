#!/bin/bash

# Record the statistics for the height (trimming whitespace).
min_height=$(psql $database -U $user -t -c "SELECT min(height_scrubbed)::NUMERIC(16,4) FROM library WHERE height_scrubbed IS NOT NULL")
min_height=${min_height// /}

max_height=$(psql $database -U $user -t -c "SELECT max(height_scrubbed)::NUMERIC(16,4) FROM library WHERE height_scrubbed IS NOT NULL")
max_height=${max_height// /}

average_height=$(psql $database -U $user -t -c "SELECT avg(height_scrubbed)::NUMERIC(16,4) FROM library WHERE height_scrubbed IS NOT NULL")
average_height=${average_height// /}

stddev_height=$(psql $database -U $user -t -c "SELECT stddev_samp(height_scrubbed)::NUMERIC(16,4) FROM library WHERE height_scrubbed IS NOT NULL")
stddev_height=${stddev_height// /}

# Record the statistics for the width (trimming whitespace).
min_width=$(psql $database -U $user -t -c "SELECT min(width_scrubbed)::NUMERIC(16,4) FROM library WHERE width_scrubbed IS NOT NULL")
min_width=${min_width// /}

max_width=$(psql $database -U $user -t -c "SELECT max(width_scrubbed)::NUMERIC(16,4) FROM library WHERE width_scrubbed IS NOT NULL")
max_width=${max_width// /}

average_width=$(psql $database -U $user -t -c "SELECT avg(width_scrubbed)::NUMERIC(16,4) FROM library WHERE width_scrubbed IS NOT NULL")
average_width=${average_width// /}

stddev_width=$(psql $database -U $user -t -c "SELECT stddev_samp(width_scrubbed)::NUMERIC(16,4) FROM library WHERE width_scrubbed IS NOT NULL")
stddev_width=${stddev_width// /}

# Record the statistics for the thickness (trimming whitespace).
min_thickness=$(psql $database -U $user -t -c "SELECT min(thickness_scrubbed)::NUMERIC(16,4) FROM library WHERE thickness_scrubbed IS NOT NULL")
min_thickness=${min_thickness// /}

max_thickness=$(psql $database -U $user -t -c "SELECT max(thickness_scrubbed)::NUMERIC(16,4) FROM library WHERE thickness_scrubbed IS NOT NULL")
max_thickness=${max_thickness// /}

average_thickness=$(psql $database -U $user -t -c "SELECT avg(thickness_scrubbed)::NUMERIC(16,4) FROM library WHERE thickness_scrubbed IS NOT NULL")
average_thickness=${average_thickness// /}

total_thickness=$(psql $database -U $user -t -c "SELECT sum(thickness_scrubbed)::NUMERIC(16,4) FROM library WHERE thickness_scrubbed IS NOT NULL")
total_thickness=${total_thickness// /}

stddev_thickness=$(psql $database -U $user -t -c "SELECT stddev_samp(thickness_scrubbed)::NUMERIC(16,4) FROM library WHERE thickness_scrubbed IS NOT NULL")
stddev_thickness=${stddev_thickness// /}

# Record the statistics for the weight (trimming whitespace).
min_weight=$(psql $database -U $user -t -c "SELECT min(weight_scrubbed)::NUMERIC(16,4) FROM library WHERE weight_scrubbed IS NOT NULL")
min_weight=${min_weight// /}

max_weight=$(psql $database -U $user -t -c "SELECT max(weight_scrubbed)::NUMERIC(16,4) FROM library WHERE weight_scrubbed IS NOT NULL")
max_weight=${max_weight// /}

average_weight=$(psql $database -U $user -t -c "SELECT avg(weight_scrubbed)::NUMERIC(16,4) FROM library WHERE weight_scrubbed IS NOT NULL")
average_weight=${average_weight// /}

total_weight=$(psql $database -U $user -t -c "SELECT sum(weight_scrubbed)::NUMERIC(16,4) FROM library WHERE weight_scrubbed IS NOT NULL")
total_weight=${total_weight// /}

stddev_weight=$(psql $database -U $user -t -c "SELECT stddev_samp(weight_scrubbed)::NUMERIC(16,4) FROM library WHERE weight_scrubbed IS NOT NULL")
stddev_weight=${stddev_weight// /}

# Summary output.
echo "Heights of Books, in Inches:"
printf "\tMinimum: ${min_height}\n" # Used for \t tabs.
printf "\tMaximum: ${max_height}\n"
printf "\tAverage: ${average_height}\n"
printf "\tStandard Deviation: ${stddev_height}\n"
echo
echo "Widths of Books, in Inches:"
printf "\tMinimum: ${min_width}\n"
printf "\tMaximum: ${max_width}\n"
printf "\tAverage: ${average_width}\n"
printf "\tStandard Deviation: ${stddev_width}\n"
echo
echo "Thicknesses of Books, in Inches:"
printf "\tMinimum: ${min_thickness}\n"
printf "\tMaximum: ${max_thickness}\n"
printf "\tAverage: ${average_thickness}\n"
printf "\tTotal: ${total_thickness}\n"
printf "\tStandard Deviation: ${stddev_thickness}\n"
echo
echo "Weights of Books, in Pounds:"
printf "\tMinimum: ${min_weight}\n"
printf "\tMaximum: ${max_weight}\n"
printf "\tAverage: ${average_weight}\n"
printf "\tTotal: ${total_weight}\n"
printf "\tStandard Deviation: ${stddev_weight}\n"
echo
