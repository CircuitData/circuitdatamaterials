module ApplicationHelper
  include Pagy::Frontend

  def materials_to_compare
    session[:compare] ||= []
  end
end
