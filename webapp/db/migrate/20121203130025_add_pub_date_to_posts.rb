class AddPubDateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pubdate, :timestamp
  end
end
