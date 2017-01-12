module Manage
  module DashboardHelper
    def cache_key_for_questionnaires
      count          = Questionnaire.count
      max_updated_at = Questionnaire.maximum(:updated_at).try(:utc).try(:to_s, :number)
      "questionnaires/all-#{count}-#{max_updated_at}"
    end
  end
end
