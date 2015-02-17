class AddAgreementAcceptedToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :agreement_accepted, :boolean, default: false
  end
end
