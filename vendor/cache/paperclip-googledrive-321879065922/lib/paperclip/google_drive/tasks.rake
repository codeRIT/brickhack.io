
require "paperclip/google_drive/rake"

namespace :google_drive do
  desc "Authorize Google Drive account: "
  task :authorize do
    Paperclip::GoogleDrive::Rake.authorize
  end
end

