require "helpers/commoditylive"
require "json"

namespace :commoditylive do
  desc "Update all materials"
  task :materials => :environment do
    commoditylive = Commoditylive.new("live")
    clas_id = "017adf82-c93c-4ba7-8bf0-2274208399a4"
    @com_ids = []
    success, response = commoditylive.get_all_materials(clas_id)
    if success
      JSON.parse(response)["data"]["relationships"]["commodities"]["data"].each do |com|
        @com_ids << com["id"]
      end
    end
    @com_ids.uniq!
    puts "Updating " + @com_ids.count.to_s + " Materials"
    @com_ids.each do |com_id|
      success, response = commoditylive.get_material(com_id)
      puts com_id
      if success
        response = JSON.parse(response)
        puts response["data"]["attributes"]["name"]
        unless response["data"]["relationships"]["brand"]["data"] == nil
          puts "inside if"
          puts response["data"]["relationships"]["brand"]["data"]
          manufacturer = Manufacturer.find_or_create_by(source_id: response["data"]["relationships"]["brand"]["data"]["id"]).update(
            name: response["data"]["attributes"]["brand"]["name"],
            source: "COMMODITY.LIVE",
            description: response["data"]["attributes"]["brand"]["description"],
            location: response["data"]["attributes"]["brand"]["location"],
            verified: response["data"]["attributes"]["brand"]["official"],
          )
          puts manufacturer
          manu = Manufacturer.find_by_name(response["data"]["attributes"]["brand"]["name"])
          puts manu
        else
          manu = nil
        end
        material = Material.find_or_create_by(source_id: com_id).update(
          name: response["data"]["attributes"]["name"],
          source: "COMMODITY.LIVE",
          version: "1.0",
          function: "dielectric",
          group: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "group" }.dig("value") rescue nil),
          manufacturer_id: manu.nil? ? nil : manu.id,
          link: (response.dig("data", "attributes", "links").first.dig("url") rescue nil),
          remark: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "remark" }.dig("value") rescue nil),
          additional: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "additional" }.dig("value") rescue nil),
          flexible: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "flexible" }.dig("value") rescue nil),
          ul_94: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "ul_94" }.dig("value") rescue nil),
          accept_equivalent: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "accept_equivalent" }.dig("value") rescue nil),
          verified: (response.dig("data", "attributes", "specifications").find { |spec| spec["property"] == "verified" }.dig("value") rescue nil),
          ipc_standard: (response.dig("data", "attributes", "standards").first.dig("code") rescue nil),
        )

        mat = Material.find_by_source_id(com_id)
        puts mat
        # Gather list of possible Material Attributes (Specifications like ipc_slash_sheet)
        specs = []
        response["data"]["attributes"]["specifications"].each do |s|
          puts s["property"]
          puts "next"
          specs << s unless ["group", "remark", "additional", "flexible", "ul_94", "accept_equivalent", "verified"].include?(s["property"])
        end
        puts specs.class
        puts specs.count
        specs.reject { |item| item.nil? || item == "" }.each do |spec|
          puts "inside spec"
          puts spec
          MaterialAttribute.find_or_create_by(name: spec["property"], material_id: mat.id)
          ma = MaterialAttribute.find_by(name: spec["property"], material_id: mat.id)
          MaterialAttributeValue.find_or_create_by(material_attribute_id: ma.id).update(value: spec["value"], value_type: spec["format_name"])
        end
      end
    end
  end
end
