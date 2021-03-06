COPY
	(	SELECT
			CASE	WHEN	${max_height} != ${min_height}
				THEN	((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION) * floor(height_scrubbed::DOUBLE PRECISION/((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)) + ((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)/2.0  		ELSE	${max_height}
				END AS "Height Bin"
		,	CASE	WHEN	${max_width} != ${min_width}
				THEN	((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION) * floor(width_scrubbed::DOUBLE PRECISION/((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)) + ((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)/2.0  		ELSE	${max_width}
				END AS "Width Bin"
		,	COUNT(*) AS "Number of Books"
		FROM
			library
		WHERE
			"cluster" = ${cluster}::TEXT
		GROUP BY
			1, 2
		ORDER BY
			1 ASC, 2 ASC)
TO
	'${DIR}/working/cluster_${cluster}/book_heights_widths_summary.csv'
(	FORMAT csv
,	DELIMITER ','
,	HEADER
,	NULL ''	);

COPY
	(	SELECT
			CASE	WHEN	${max_height} != ${min_height}
				THEN	((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION) * floor(height_scrubbed::DOUBLE PRECISION/((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)) + ((${max_height}-${min_height})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)/2.0  		ELSE	${max_height}
				END AS "Height Bin"
		,	CASE	WHEN	${max_width} != ${min_width}
				THEN	((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION) * floor(width_scrubbed::DOUBLE PRECISION/((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)) + ((${max_width}-${min_width})::DOUBLE PRECISION/${n_intervals}::DOUBLE PRECISION)/2.0  		ELSE	${max_width}
				END AS "Width Bin"
		,	SUM(thickness_scrubbed) AS "Inches of Books"
		FROM
			library
		WHERE
			"cluster" = ${cluster}::TEXT
		AND	thickness_scrubbed IS NOT NULL
		GROUP BY
			1, 2
		ORDER BY
			1 ASC, 2 ASC)
TO
	'${DIR}/working/cluster_${cluster}/book_heights_widths_weighted_summary.csv'
(	FORMAT csv
,	DELIMITER ','
,	HEADER
,	NULL ''	);

COPY
	(	SELECT
			book_id AS "Book ID"
		,	height_scrubbed AS "Height (in)"
		,	width_scrubbed AS "Width (in)"
		,	thickness_scrubbed AS "Thickness (in)"
		,	weight_scrubbed AS "Weight (lb)"
		FROM
			library
		WHERE
			"cluster" = ${cluster}::TEXT	)
TO
	'${DIR}/working/cluster_${cluster}/book_dimensions_summary.csv'
(	FORMAT csv
,	DELIMITER ','
,	HEADER
,	NULL ''	);
