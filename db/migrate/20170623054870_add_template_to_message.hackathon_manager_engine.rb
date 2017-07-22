# This migration comes from hackathon_manager_engine (originally 20150326031423)
class AddTemplateToMessage < ActiveRecord::Migration[4.2]
  def change
    add_column :messages, :template, :string, default: "default"
  end
end
