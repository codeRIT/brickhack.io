class AddTemplateToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :template, :string, default: "default"
  end
end
