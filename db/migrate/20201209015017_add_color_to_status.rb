class AddColorToStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :color, :string
  end
end
