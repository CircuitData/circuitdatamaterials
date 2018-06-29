class MaterialsController < ApplicationController

  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end

  def index

    params.permit(:name, :group, :link, :version, :verified, :source, :function, :flexible, :additional, :remark, :ul_94, :accept_equivalent, :ipc_standard, :manufacturer)
  
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : 40
    @first = true
    materials = Material.find_by_sql("SELECT m.version, m.name, m.verified, m.id, m.source, m.source_id, m.function, m.group, m.flexible, m.additional, m.link, m.remark, m.ul_94, m.accept_equivalent, m.ipc_standard, m.manufacturer_id, mf.name AS manufacturer
      FROM materials AS m
      LEFT JOIN manufacturers AS mf ON m.manufacturer_id = mf.id
      #{gen_search('materials')}
      LIMIT #{per_page} OFFSET #{(page-1)*per_page};");
    materials = materials.as_json
   # 2nd loop - add the attributes into material
   materials.each{|material|
     attributes = MaterialAttribute.find_by_sql("SELECT ma.id, ma.name
       FROM material_attributes AS ma
       WHERE '#{material["id"]}' = ma.material_id");
       # need to add {gen_search('attributes')}
     test_attributes = []
     # 3rd loop - add the value into attributes
     attributes.as_json.each{|attribute|
       values = MaterialAttributeValue.find_by_sql("SELECT mav.id, mav.value, mav.value_type
         FROM material_attribute_values AS mav
         WHERE '#{attribute["id"]}' = mav.material_attribute_id");
         # need to add {gen_search('attributes')}
       # add the attributes into material
       attribute[:values] = values.as_json
       test_attributes << attribute

     }
     material[:material_attributes] = test_attributes.as_json
   }
  if params[:attribute_name]
    materials = materials.collect{|c| c if c[:material_attributes].count > 0}.compact
  end
    if materials.count > 0
      if params[:endpoint] == 'cdp'
    	new_material = []
    	new_materials = []
    	materials.each do |m|
          m.each do |k,v|
    	    puts k.to_s + ' value:  ' + v.to_s
    	    if k == 'manufacturer' and v
    	      new_material << {k => v.name}
    	    elsif k.to_s == 'material_attributes' and v 
    	      att = []
    	      v.each do |av|
    	      	if av['values'].first['value_type'] == 'Decimal'
    	      	  val = av['values'].first['value'].to_f rescue av['values'].first['value']
    	      	elsif av['values'].first['value_type'] == 'Numeric'
    	      	  val = av['values'].first['value'].to_i rescue av['values'].first['value']
    	      	elsif av['values'].first['value_type'] == 'Drop-down list'
    	      	  val = JSON.parse(av['values'].first['value']) rescue av['values'].first['value']
                else
    	      	  val = av['values'].first['value']
    	      		#puts 'this is the val: ' + val
                end
    	      	att << {av['name'] => val} unless av['values'].first['value'] == nil
    	      end
    	      new_material << {'attributes' => att.reduce({}, :merge)}
    	    elsif k.to_s == 'id' and v
    	      new_material << {'circuitdata_material_db_id' => v}
    	    elsif k.to_s == 'ul_94' and v
    	      new_material << {'ul94' => v}  	      
    	    elsif k.to_s == 'version' and v
    	      new_material << {k => v.to_f}  	      
    	    else  
    		  new_material << {k => v} unless v == nil or k.to_s == 'manufacturer_id' or k.to_s == 'additional' or k.to_s == 'verified'
    	      #puts 'intserted key: ' + k.to_s  
    	    end
    	  end
    	  new_materials << new_material.reduce({}, :merge)
    	end
        (new_materials.uniq {|e| e[:name] }).each do |n|
          if n["manufacturer"]
          	puts 'by'
            n["name"] = n["name"] + ' by ' + n["manufacturer"]
          else
        	n["name"] = n["name"] + '-1' 
          end
        end

        render json: new_materials, status: :ok
      else
        render json: materials, status: :ok
      end
    else
	  raise ActiveRecord::RecordNotFound,"No records found for parameters: " + params.to_json
    end
  end

  private
  def search_params
    params.permit(:name, :link)
  end
  def columns
    # the exclude tell us which query to exclude
    [
        {name: 'manufacturer_name', table_name: 'name', allow: ['materials'], table: 'mf.'},
        {name: 'attribute_name', table_name: 'name', allow: ['attributes'], table: 'ma.'},
        {name: 'name', allow: ['materials'], table: 'm.'},
        #{name: 'name', allow: ['materials'], table: {materials: 'mf.'}},
        {name: 'function', allow: ['materials'], table: 'm.'},
        {name: 'group', allow: ['materials'], table: 'm.'},
        {name: 'circuitdata_version', allow: ['materials'], table: 'm.'},
        {name: 'verified', allow: ['materials'], table: 'm.'},
        {name: 'source', allow: ['materials'], table: 'm.'},
        {name: 'flexible', allow: ['materials'], table: 'm.'},
        {name: 'additional', allow: ['materials'], table: 'm.'},
        {name: 'link', allow: ['materials'], table: 'm.'},
        {name: 'remark', allow: ['materials'], table: 'm.'},
        {name: 'ul_94', allow: ['materials'], table: 'm.'},
        {name: 'accept_equivalent', allow: ['materials'], table: 'm.'},
        {name: 'ipc_standard', allow: ['materials'], table: 'm.'},
        {name: 'value', allow: ['values'], table: 'mav.'},
        {name: 'type', allow: ['values'], table: 'mav.'}
    ]
  end

  def gen_search(type)
    cols = columns.select{|c| c[:allow].include?(type)}
    # if_search = cols.each{|c| params[c[:name].to_sym].present?}
    if_search = cols.each{|c| params[c[:name].to_sym].present?}
    if if_search
      query, first = "#{type == 'materials' ? 'WHERE' : ''} (", true
      cols.each{|c|
        # name, table = c[:name], cols.first.dig(:table, type.to_sym)
        name, table = c[:name], c[:table]
        # if params[name.to_sym].present?
        if params[c[:name].to_sym].present?
          query += (first ? '' : ' AND ') + "#{table if table.present?}#{c[:table_name].present? ? c[:table_name] : name} ILIKE '%#{params[name.to_sym]}%'"
        #  binding.pry if table.present?
          first = false # should change on the first loop
        end
      }
      query += ')'
      #binding.pry 
      query[-2,2] == '()' ? '' : query;
    else
      ''
    end
  end
end