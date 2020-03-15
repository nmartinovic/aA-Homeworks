class Tagging < ApplicationRecord

    has_one(
        :topic,
        class_name: 'TagTopic',
        foreign_key: :tag_name,
        primary_key: :tag_name
    )

    has_one(
        :short_link,
        class_name: 'Shortened_Url',
        primary_key: :long_url,
        foreign_key: :long_url
    )
end