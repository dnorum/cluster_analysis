SELECT
	COUNT(*)
FROM
	library
WHERE
	height_scrubbed IS NULL
AND	width_scrubbed IS NULL
AND	thickness_scrubbed IS NULL
