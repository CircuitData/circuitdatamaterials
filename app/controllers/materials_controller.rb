class MaterialsController < ApplicationController
  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end

  def index
    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : 40
    @first = true
    materials = Material.offset((page - 1) * per_page).limit(per_page)
    render json: materials
  end

  def datasheet
    @material = Material.find(params[:id])
    sheet = @material.datasheet
    return send_sheet(sheet) if sheet.exist?
  end

  private

  def send_sheet(sheet)
    send_data(
      sheet.contents.read,
      filename: sheet.filename,
      type: "application/pdf",
      disposition: "inline",
    )
  end

  def search_params
    params.permit(:name, :link)
  end

  def columns
    [
      { name: "group_name", table_name: "name", allow: ["materials"], table: "g." },
      { name: "function_name", table_name: "name", allow: ["materials"], table: "f." },
      { name: "manufacturer_name", table_name: "name", allow: ["materials"], table: "mf." },
      { name: "attribute_name", table_name: "name", allow: ["attributes"], table: "ma." },
      { name: "name", allow: ["materials"], table: "m." },
      { name: "function", allow: ["materials"], table: "m." },
      { name: "group", allow: ["materials"], table: "m." },
      { name: "circuitdata_version", allow: ["materials"], table: "m." },
      { name: "verified", allow: ["materials"], table: "m." },
      { name: "source", allow: ["materials"], table: "m." },
      { name: "flexible", allow: ["materials"], table: "m." },
      { name: "additional", allow: ["materials"], table: "m." },
      { name: "link", allow: ["materials"], table: "m." },
      { name: "remark", allow: ["materials"], table: "m." },
      { name: "ul_94", allow: ["materials"], table: "m." },
      { name: "accept_equivalent", allow: ["materials"], table: "m." },
      { name: "ipc_standard", allow: ["materials"], table: "m." },
      { name: "value", allow: ["values"], table: "mav." },
      { name: "type", allow: ["values"], table: "mav." },
    ]
  end

  def gen_search(type)
    cols = columns.select { |c| c[:allow].include?(type) }
    if_search = cols.each { |c| params[c[:name].to_sym].present? }
    if if_search
      query, first = "#{type == "materials" ? "WHERE" : ""} (", true
      cols.each { |c|
        name, table = c[:name], c[:table]
        if params[c[:name].to_sym].present?
          query += (first ? "" : " AND ") + "#{table if table.present?}#{c[:table_name].present? ? c[:table_name] : name} ILIKE '%#{params[name.to_sym]}%'"
          first = false # should change on the first loop
        end
      }
      query += ")"
      query[-2, 2] == "()" ? "" : query
    else
      ""
    end
  end
end
