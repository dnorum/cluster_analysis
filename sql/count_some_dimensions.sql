SELECT
	COUNT(*)
FROM
	library
WHERE
	(	height_scrubbed IS NOT NULL
	OR	width_scrubbed IS NOT NULL
	OR	thickness_scrubbed IS NOT NULL
	OR	weight_scrubbed IS NOT NULL	)
AND	(	height_scrubbed IS NULL
	OR	width_scrubbed IS NULL
	OR	thickness_scrubbed IS NULL
	OR	weight_scrubbed IS NULL	)
