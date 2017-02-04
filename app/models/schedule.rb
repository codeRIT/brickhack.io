require 'httparty'
SHEETS_KEY = ENV['GOOGLESHEETS_KEY']
SHEETS_URL = "https://sheets.googleapis.com/v4/spreadsheets/".freeze
SHEETS_FIELDS = "fields=sheets(data.rowData.values.userEnteredValue)".freeze
SECTION = ":section".freeze
ITEM = ":item".freeze

class Schedule
  def initialize(spreadsheet_id, sheet = 0)
    cache_key = "schedule/#{spreadsheet_id}"
    parsed_response = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      response = HTTParty.get(SHEETS_URL + "#{spreadsheet_id}?#{SHEETS_FIELDS}&key=#{SHEETS_KEY}")
      response ? response.parsed_response.to_hash : nil
    end

    unless parsed_response && parsed_response["error"].nil?
      Rails.logger.error "Error reading Google Sheet #{spreadsheet_id}"
      return
    end

    @sheet = parsed_response["sheets"][sheet]
  end

  def rows
    @sheet ? @sheet["data"][0]["rowData"] : []
  end

  def sections
    section = []
    sections = []
    rows.each do |row|
      if row["values"][0]["userEnteredValue"]["stringValue"] == SECTION
        sections << section unless section.count.zero?
        section = [row["values"][1]["userEnteredValue"]["stringValue"]]
      else
        fill_section(section, row)
      end
    end
    sections << section unless section.empty?
    sections
  end

  private

  def fill_section(section, row)
    r = []
    row["values"].map do |col|
      next if !col.empty? && col["userEnteredValue"]["stringValue"] == ITEM
      r << (col.empty? ? '' : col["userEnteredValue"]["stringValue"])
    end
    section << r unless r.count.zero?
  end
end
