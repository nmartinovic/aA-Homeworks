class CreateTagTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_topics do |t|
      t.string :tag_name, null:false, unique: true
    end

    add_index :tag_topics, :tag_name
  end
end
