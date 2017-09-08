# This migration comes from hackathon_manager_engine (originally 20150110222455)
class AddPortfolioAndVcsUrlsToRegistrations < ActiveRecord::Migration[4.2]
  def change
    add_column :registrations, :portfolio_url, :string
    add_column :registrations, :vcs_url, :string
  end
end
