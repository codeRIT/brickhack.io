class AddAgreementAcceptedToQuestionnaires < ActiveRecord::Migration[4.2]
  def change
    add_column :questionnaires, :agreement_accepted, :boolean, default: false
  end
end
