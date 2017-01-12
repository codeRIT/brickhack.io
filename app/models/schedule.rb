require 'httparty'
SHEETS_KEY = ENV['GOOGLESHEETS_KEY']
SHEETS_URL = "https://sheets.googleapis.com/v4/spreadsheets/".freeze
SHEETS_FIELDS = "fields=sheets(data.rowData.values.userEnteredValue)".freeze
SECTION = ":section".freeze
ITEM = ":item".freeze

class Schedule
  attr_reader :name

  def initialize(name, spreadsheet_id, ranges, sheet = 0)
    @name = name
    response = HTTParty.get(SHEETS_URL + "#{spreadsheet_id}?ranges=#{ranges}&#{SHEETS_FIELDS}&key=#{SHEETS_KEY}")
    @sheet = response.parsed_response["sheets"][sheet]
    @sections = []
  end

  def rows
    return @sheet["data"][0]["rowData"] if @sheet
  end

  def sections
    section = []
    rows.each do |row|
      if row["values"][0]["userEnteredValue"]["stringValue"] == SECTION
        @sections << section unless section.count.zero?
        section = [row["values"][1]["userEnteredValue"]["stringValue"]]
      else
        fill_section(section, row)
      end
    end
    return @sections << section unless section.count.zero?
  end

  private

  def fill_section(section, row)
    r = []
    row["values"].map { |col| r << col["userEnteredValue"]["stringValue"] unless col["userEnteredValue"]["stringValue"] == ITEM }
    section << r unless r.count.zero?
  end
end
