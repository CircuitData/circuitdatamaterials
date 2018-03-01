class MaterialsController < ApplicationController
  def index
  	@materials = Material.all  	
  	if params.keys.count > 2
  	  unless (Material.attribute_names & params.keys).empty?
  	    params.each do |k,v|
  	      if Material.attribute_names.include? k
 	      	if k == 'name'
  	          @materials = @materials.where('name ilike ?', "%#{v}%")
  	        else
              @materials = @materials.where(k => v)
            end
  	        unless @materials.present?
  	        	raise ActiveRecord::RecordNotFound,"Material did not match: " + k + ": " + v
  	        end
  	      end
  	    end
  	  else
  	  	unless params[:page] or params[:per_page]
  	      raise ActiveRecord::RecordNotFound,"No matching parameters: " + params.keys.to_s
        end
  	  end
    end
    if @materials.present?
      paginate json: @materials, status: :ok
    else
      raise ActiveRecord::RecordNotFound,"Material did not match: " + params.to_s
    end
  end

  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end
end
