namespace :csv do

  FIELDS = [
    "ipc_standard",
    "ipc_slash_sheet",
    "tg_min",
    "dk",
    "ul_94",
    "cti",
    "df",
    "td_min",
    "t260",
    "t280",
    "t300",
    "mot",
    "z_cte",
    "z_cte_before_tg",
    "z_cte_after_tg",
    "dielectric_breakdown",
    "water_absorption",
    "thermal_conductivity"
  ]

  task :export => :environment do
    puts MaterialDbToCsv.new.to_csv
  end

  task :dump => :environment do
    f = File.open(Rails.root.join("lib", "data", "materials.csv"), "w")
    f.write MaterialDbToCsv.new.to_csv

    f = File.open(Rails.root.join("lib", "data", "manufacturers.csv"), "w")
    f.write ManufacturerDbToCsv.new.to_csv
  end

  task :load => :environment do
    ActiveRecord::Base.connection.transaction do
      Material.delete_all
      Manufacturer.delete_all
      f = File.open(Rails.root.join("lib", "data", "manufacturers.csv"))
      ManufacturerCsvToDb.new(f.read).load_into_db

      f = File.open(Rails.root.join("lib", "data", "materials.csv"))
      MaterialCsvToDb.new(f.read).load_into_db
    end
  end

  task :clean => :environment do
    f = File.open(Rails.root.join("lib", "data", "data_cleanup.csv"), "r")
    MaterialCsvToDb.new(f.read).materials.each do |from_ec|
      from_cdp = MaterialDbToCsv.new.body.select{|m|
        m[:name] == from_ec["name"] &&
        !from_ec[:manufacturer].nil? &&
        m[:manufacturer] == from_ec[:manufacturer]["name"]
      }.first
      if from_cdp.nil?
        from_cdp = MaterialDbToCsv.new.body.select{|m|
          m[:circuitdata_material_db_id] == from_ec[:id]
        }.first
      end
      puts from_ec["name"]
      from_ec["ipc_slash_sheet"] = from_ec[:ipc_slash_sheet].nil? ? "" : from_ec[:ipc_slash_sheet].join("|")
      FIELDS.each do |field|
        if from_ec[field].to_s != "" && from_ec[field].to_s != from_cdp[field.to_sym].to_s
          puts "\tUpdating "+field+" from "+from_cdp[field.to_sym].to_s+" to "+from_ec[field].to_s
        else
          #puts "Keeping "+field+" cdp: "+from_cdp[field.to_sym].to_s+" EC: "+from_ec[field].to_s
        end
      end
    end
  end
end
