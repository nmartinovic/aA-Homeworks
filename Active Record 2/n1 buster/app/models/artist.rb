class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
#   Artist Load (0.7ms)  SELECT  "artists".* FROM "artists" ORDER BY "artists"."id" ASC LIMIT $1  [["LIMIT", 1]]
#   Album Load (2.5ms)  SELECT albums.*, COUNT(*) AS tracks_count FROM "albums" INNER JOIN "tracks" ON "tracks"."album_id" = "albums"."id" WHERE "albums"."artist_id" = $1 GROUP BY albums.id  [["artist_id", 1]]
# => {"Lemonade"=>8, "I Am... Sasha Fierce"=>6, "Dangerously in Love"=>3, "B'Day"=>4, "4"=>1}
    ao_object = self.albums.joins(:tracks).select("albums.*","COUNT(*) AS tracks_count").group("albums.id")
    final = {}
    ao_object.each do |i|
      final[i.title] =  i.tracks_count
    end
    final
  end
end
