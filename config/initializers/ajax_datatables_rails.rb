AjaxDatatablesRails.configure do |config|
  # available options for db_adapter are: :pg, :mysql2, :sqlite3
  if Rails.env.development? || Rails.env.test?
    config.db_adapter = :sqlite3
  else
    config.db_adapter = :mysql2
  end
end
