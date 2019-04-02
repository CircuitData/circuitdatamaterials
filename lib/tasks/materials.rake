namespace :materials do
  task download_missing_datasheets: :environment do
    DatasheetDownloader.start
  end
end
