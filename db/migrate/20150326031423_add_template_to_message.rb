class AddTemplateToMessage < ActiveRecord::Migration[4.2]
  def change
    add_column :messages, :template, :string, default: "default"
  end
end
