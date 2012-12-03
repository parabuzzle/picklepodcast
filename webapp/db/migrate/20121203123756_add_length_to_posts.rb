class AddLengthToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :length, :string
  end
end
