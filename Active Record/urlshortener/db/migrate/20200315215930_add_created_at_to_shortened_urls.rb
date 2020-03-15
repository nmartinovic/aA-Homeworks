class AddCreatedAtToShortenedUrls < ActiveRecord::Migration[5.1]
  def change
      add_timestamps :shortened_urls, default: Time.zone.now
      change_column_default :shortened_urls, :created_at, nil
      change_column_default :shortened_urls, :updated_at, nil
  end
end
