namespace :materials do
  task :download_missing_datasheets, [:manufacturer] => :environment do |t, args|
    manufacturer = args[:manufacturer]
    scope = Material
    if manufacturer.present?
      scope = scope.joins(:manufacturer).where(manufacturers: { name: manufacturer })
    end
    DatasheetDownloader.start(scope)
  end
end
