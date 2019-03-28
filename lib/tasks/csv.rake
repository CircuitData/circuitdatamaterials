namespace :csv do
  task :export => :environment do
    puts DbToCsv.new.to_csv
  end
end
