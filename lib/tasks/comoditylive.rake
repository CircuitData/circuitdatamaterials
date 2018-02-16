require 'helpers/commoditylive'
require 'json'
#require DateTime

namespace :commoditylive do

  desc "Update all materials"
  task :materials => :environment do

    # Start Time
    $starttime = Time.now()

    commoditylive = Commoditylive.new('live')
    clas_id =  "017adf82-c93c-4ba7-8bf0-2274208399a4"
    @com_ids = []
    success, response = commoditylive.get_all_materials(clas_id)
    if success
      JSON.parse(response)["data"]["relationships"]["commodities"]["data"].each do |com|
        @com_ids << com["id"]
      end
    end
    @com_ids.uniq!
    puts @com_ids.count
    @com_ids.each do |com_id|
    success, response = commoditylive.get_material(com_id)
    if success
      puts response
      response = JSON.parse(response)
      manufacturer = Manufacturer.find_or_create_by(name: response["data"]["attributes"]["brand"]["name"]).update(
        description: response["data"]["attributes"]["description"],
        location: response["data"]["attributes"]["location"]
        )
      puts manufacturer
      manu = Manufacturer.find_by_name(response["data"]["attributes"]["brand"]["name"])
      puts manu
      material = Material.find_or_create_by(name: response["data"]["attributes"]["name"], manufacturer_id: manu.id).update(
        function: "dielectric", 
        group: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'group'}.dig("value") rescue nil),
        manufacturer_id: manu.id,
        link: (response.dig("data", "attributes", "links").first.dig("url") rescue nil) ,
        remark: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'remark'}.dig("value") rescue nil) ,
        additional: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'additional'}.dig("value") rescue nil) ,
        flexible: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'flexible'}.dig("value") rescue nil),
        ul_94: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'ul_94'}.dig("value") rescue nil) ,
        accept_equivalent: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'accept_equivalent'}.dig("value") rescue nil) ,
        verified: (response.dig("data", "attributes", "specifications").find{|spec| spec["property"] == 'verified'}.dig("value") rescue nil) 
        )
        mat = Material.find_by_name(response["data"]["attributes"]["name"])
        # Gather list of possible Material Attributes (Specifications like ipc_slash_sheet)
        specs = []
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "ipc_slash_sheet" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "tg_min" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "td_min" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "resin" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "resin_content" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "flame_retardant" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "woven_reinforcement" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "filler" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "reinforcement" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "thickness" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "dk" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "cti" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "frequency" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "df" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "t260" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "t280" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "t300" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "mot" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "z_cte" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "z_cte_before_tg" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "z_cte_after_tg" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "dielectric_breakdown" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "water_absorption" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "thermal_conductivity" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "volume_resistivity" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "electric_strength" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "foil_roughness" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "ipc_sm_840_class" }[0]
        specs << response["data"]["attributes"]["specifications"].select {|specification| specification["property"] == "finish" }[0]

        specs.reject { |item| item.nil? || item == '' }.each do |spec|
          MaterialAttribute.find_or_create_by(name: spec["property"], material_id: mat.id)
          ma = MaterialAttribute.find_by_name(spec["property"])
          MaterialAttributeValue.find_or_create_by(material_attribute_id: ma.id).update(value: spec["value"])
        end
      end
    end
  end
end