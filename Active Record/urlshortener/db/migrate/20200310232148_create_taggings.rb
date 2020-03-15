class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.string :long_url, null: false
      t.string :tag_name, null:false
    end
    add_index :taggings, :long_url
    add_index :taggings, :tag_name
  end

end
