class AddDurationToPost < ActiveRecord::Migration
  def change
    add_column :posts, :duration, :string
  end
end
