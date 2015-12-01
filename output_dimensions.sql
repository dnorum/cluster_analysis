COPY
	(	SELECT
			book_id AS "Book ID"
		,	height_scrubbed AS "Height (in)"
		,	length_scrubbed AS "Width (in)"
		,	thickness_scrubbed AS "Thickness (in)"
		FROM
			library
		WHERE
			height_scrubbed IS NOT NULL	)
TO
	'/home/don/projects/git/cluster_shelving/working/book_dimensions.csv'
(	FORMAT csv
,	DELIMITER ','
,	NULL ''	);