class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.column :title, :string, :null=>false
      t.column :url, :string, :null=>false
      t.column :body, :text
      t.column :mp3, :string
      t.column :draft, :boolean, :default=>true
      t.timestamps
    end
  end
end
