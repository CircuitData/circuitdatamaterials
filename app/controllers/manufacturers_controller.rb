class ManufacturersController < ApplicationController
  def index
  	@manufacturers = Manufacturer.all
  	if params.keys.count > 2
  	  unless (Manufacturer.attribute_names & params.keys).empty?
  	    params.each do |k,v|
  	      if Manufacturer.attribute_names.include? k
  	      	if k == 'name'
  	          @manufacturers = @manufacturers.where('name ilike ?', "%#{v}%")
  	        else
              @manufacturers = @manufacturers.where(k => v)
            end
  	        unless @manufacturers.present?
  	        	raise ActiveRecord::RecordNotFound,"Manufacturer did not match: " + k + ": " + v
  	        end
  	      end
  	    end
  	  else
  	  	unless params[:page] or params[:per_page]
  	      raise ActiveRecord::RecordNotFound,"No matching parameters: " + params.keys.reject { |k| k == 'controller' or k == 'action'}.to_s
        end
      end
    end
    if @manufacturers.present?
      paginate json: @manufacturers, status: :ok
    else
      raise ActiveRecord::RecordNotFound,"Manufacturer did not match: " + params.to_s
    end
  end
#  def index
#    @manufacturers = Manufacturer.all
#    paginate json: @manufacturers
#  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    render json: @manufacturer#, include: 'materials'
  end
end
