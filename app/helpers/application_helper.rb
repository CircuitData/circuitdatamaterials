module ApplicationHelper
  include Pagy::Frontend

  def materials_to_compare
    session[:compare] ||= session[:compare] && []
  end
end
