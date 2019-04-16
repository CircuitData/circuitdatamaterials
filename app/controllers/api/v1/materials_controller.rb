class Api::V1::MaterialsController < ApplicationController
  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end

  def index
    return send_csv if request.format == :csv

    page = params[:page].present? ? params[:page].to_i : 1
    per_page = params[:per_page].present? ? params[:per_page].to_i : 40
    materials = Material.offset((page - 1) * per_page)
      .limit(per_page)
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

  def send_csv
    send_data(
      File.read(Rails.root.join("lib", "data", "materials.csv")),
      filename: "materials.csv",
      type: "text/csv",
    )
  end
end
