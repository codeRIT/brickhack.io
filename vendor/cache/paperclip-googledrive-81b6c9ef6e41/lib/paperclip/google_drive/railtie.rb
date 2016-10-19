
module Paperclip
  module GoogleDrive
    class Railtie < Rails::Railtie
      rake_tasks do
        load "paperclip/google_drive/tasks.rake"
      end
    end
  end
end
