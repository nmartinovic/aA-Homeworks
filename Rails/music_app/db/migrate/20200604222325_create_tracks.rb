class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :album_id, null: false
      t.integer :ord, null: false
      t.string :lyrics
      t.string :name, null: false
      t.boolean :bonus?, null:false
      t.timestamps
    end
  end
end
