
class MaterialsController < ApplicationController
  include Pagy::Backend
  def index
    query = MaterialSearch.new(search_params.to_h)

    if query.has_valid_params?
      @pagy, @results = pagy(query.results)
    end
  end

  def update_compare
    add_remove_compare
    redirect_back(fallback_location: root_path)
  end

  def show
    @material = Material.find(material_id)
  end

  def update
    @material = Material.find(material_id)
    add_remove_compare
    redirect_to @material
  end

  def compare
    @materials = MaterialComparator.new(compare_material_ids).compare
  end

  def remove_from_compare
    compare_material_ids.delete(material_id)
    redirect_to :action => 'compare'
  end

  def datasheet
    @material = Material.find(material_id)
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
    params.permit(:material_name, :material_function, :manufacturer_id, :numerical_filter, :min, :max)
  end

  def add_remove_compare
    if compare_material_ids.include?(material_id)
      compare_material_ids.delete(material_id)
    else
      compare_material_ids.append(material_id)
    end
  end

  def compare_material_ids
    session[:compare]
  end

  def material_id
    params[:id]
  end
end
