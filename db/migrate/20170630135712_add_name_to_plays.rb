class AddNameToPlays < ActiveRecord::Migration[5.1]
  def change
    add_column :plays, :name, :string
  end
end
