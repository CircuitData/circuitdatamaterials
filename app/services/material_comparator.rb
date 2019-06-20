class MaterialComparator
  def initialize(params)
    if params[:material_ids].nil?
      params[:material_ids] = [nil, nil]
    end
    if params[:commit] == "Add material"
      params[:material_ids].append(nil)
    end
    @uuids = params[:material_ids]
  end

  def compare
    @uuids.map{|uuid| Material.find_by(id: uuid)}
  end
end