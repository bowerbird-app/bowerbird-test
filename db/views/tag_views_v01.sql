SELECT
  tags.*,
  coalesce(image_tags_count.count, 0) AS total_images_count
FROM
  tags
  LEFT JOIN (
    SELECT
      tag_id,
      count(*) AS count
    FROM
      image_tags
    GROUP BY
      tag_id
  ) AS image_tags_count ON tags.id = image_tags_count.tag_id;