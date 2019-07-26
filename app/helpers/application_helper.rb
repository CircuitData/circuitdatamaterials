module ApplicationHelper
  include Pagy::Frontend

  def materials_to_compare
    ActiveSupport::JSON.decode(cookies[:compare] || "[]")
  end
end
