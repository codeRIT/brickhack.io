require 'httparty'
SHEETS_KEY = ENV['GOOGLESHEETS_KEY']
SHEETS_URL = "https://sheets.googleapis.com/v4/spreadsheets".freeze
SHEETS_FIELDS = "fields=sheets(data.rowData.values.userEnteredValue)".freeze
SECTION = ":section".freeze
ITEM = ":item".freeze

class Schedule
  def initialize(spreadsheet_id, sheet = 0)
    @spreadsheet_id = spreadsheet_id

    if !sheet_data || sheet_data["error"].present?
      Rails.logger.error "Error reading Google Sheet #{spreadsheet_id}. Response: #{sheet_data['error'].inspect}"
      return
    end

    @sheet = sheet_data["sheets"][sheet]
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

  def sheet_data
    # There's two levels of caching going on here.
    # 1. "@sheet_data ||=" which caches in memory for subsequent calls to sheet_data() within the same Schedule instance / web request
    # 2. "Rails.cache" which caches between requests (up until expiry)
    @sheet_data ||= Rails.cache.fetch(cache_key, expires_in: 5.minutes) do
      response = HTTParty.get("#{SHEETS_URL}/#{@spreadsheet_id}?#{SHEETS_FIELDS}&key=#{SHEETS_KEY}")
      # to_hash is used here to guarantee Rails/Redis can cache it properly
      response ? response.parsed_response.to_hash : nil
    end
  end

  def cache_key
    "schedule/#{@spreadsheet_id}"
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
