require 'httparty'
SHEETS_KEY = ENV['GOOGLESHEETS_KEY']
SHEETS_URL = "https://sheets.googleapis.com/v4/spreadsheets/"
SHEETS_FIELDS = "fields=sheets(data.rowData.values.userEnteredValue)"
SECTION = ":section"
ITEM = ":item"

class Schedule
  def initialize(name, spreadsheet_id, sheet=0, ranges)
    @name = name
    @sheet = HTTParty
    .get(SHEETS_URL+"#{spreadsheet_id}?ranges=#{ranges}&#{SHEETS_FIELDS}&key=#{SHEETS_KEY}")
    .parsed_response["sheets"][sheet]
  end

  def rows
    return @sheet["data"][0]["rowData"] if @sheet
  end

  def sections
    @sections = []
    section = []
    rows.each do |row|
      if row["values"][0]["userEnteredValue"]["stringValue"] == SECTION
        @sections << section unless section.count == 0
        section = [row["values"][1]["userEnteredValue"]["stringValue"]]
      else
        r = []
        row["values"].map {|col| r << col["userEnteredValue"]["stringValue"] unless  col["userEnteredValue"]["stringValue"] == ITEM}
        section << r unless r.count == 0
      end
    end
    @sections << section unless section.count == 0
    return @sections
  end
end
