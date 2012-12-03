class AddPreTextToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pre, :string
  end
end
