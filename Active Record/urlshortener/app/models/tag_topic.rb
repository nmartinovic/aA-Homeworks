class TagTopic < ApplicationRecord

    has_many(
        :links,
        class_name: 'Tagging',
        primary_key: :tag_name,
        foreign_key: :tag_name
    )

    has_many(
        :short_links,
        through: :links,
        source: :short_link
    )

    has_many(
        :visits,
        through: :short_links,
        source: :clicks
    )

    def popular_links
        #short_links.joins(:visitors).group("visits.shortened_url").select("shortened_urls.id").order("COUNT(visits.shortened_url) DESC").count

        #SELECT COUNT(shortened_urls.id) AS count_shortened_urls_id, visits.shortened_url AS visits_shortened_url FROM "shortened_urls" INNER JOIN "visits" ON "visits"."shortened_url" = "shortened_urls"."short_url" INNER JOIN "taggings" ON "shortened_urls"."long_url" = "taggings"."long_url" WHERE "taggings"."tag_name" = $1 GROUP BY visits.shortened_url ORDER BY COUNT(visits.shortened_url) DESC  [["tag_name", "art"]]

        visits.group("visits.shortened_url").select("visits.shortened_url").order("COUNT(visits.shortened_url) DESC").count
        #SELECT "visits".* FROM "visits" INNER JOIN "shortened_urls" ON "visits"."shortened_url" = "shortened_urls"."short_url" INNER JOIN "taggings" ON "shortened_urls"."long_url" = "taggings"."long_url" WHERE "taggings"."tag_name" = $1  [["tag_name", "art"]]
        # short_links.joins(:visitors)
    end
end