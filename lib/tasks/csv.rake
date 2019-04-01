namespace :csv do
  task :export => :environment do
    puts DbToCsv.new.to_csv
  end

  task :dump => :environment do
    f = File.open(Rails.root.join("lib", "data", "materials.csv"), "w")
    f.write DbToCsv.new.to_csv
  end

  task :load => :environment do
    f = File.open(Rails.root.join("lib", "data", "materials.csv"))
    data = f.read
    CsvToDb.new(data).load_into_db
  end
end
