class AddNumberToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :number, :integer
  end
end
