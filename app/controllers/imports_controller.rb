class ImportsController < ApplicationController
  before_action :set_import, only: %i[show menus places venues events]

  def index
    @imports = Import.order(id: :desc)
  end

  def show; end

  # GET /imports/new
  def new
    @import = Import.new
  end

  def places
    place_helper :place
  end

  def venues
    place_helper :venue
  end

  def events
    place_helper :event
  end

  def menus
    @menus = Menu.where(import_id: menus_params[:id])
    %i[place venue event].each do |attr|
      @menus = @menus.where(attr => menus_params[attr]) if menus_params[attr]
    end
    t = Menu.arel_table
    @menus = @menus.where(t[:date].gteq(menus_params[:date_from])) if menus_params[:date_from]
    @menus = @menus.where(t[:date].lteq(menus_params[:date_to])) if menus_params[:date_to]

    render 'menus.json.jbuilder' if params[:export] == 'json'
  end

  def create
    zip_io = params[:import].try { |h| h[:zip_data] }
    @import = Import.new

    if zip_io.is_a?(ActionDispatch::Http::UploadedFile)
      filename = Time.current.to_f.to_s + zip_io.original_filename
      @import.zip_filepath = Rails.root.join('data', 'uploads', filename)

      File.open(@import.zip_filepath, 'wb') do |file|
        file.write(zip_io.read)
      end
    end

    if @import.save
      redirect_to @import, notice: 'Import was successfully created.'
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import
    @import = Import.find(params[:id])
  end

  def menus_params
    @menus_params ||=
      params.slice(:id, :place, :venue, :event)
            .merge(
              date_from: (Date.parse(params[:date_from]) rescue nil),
              date_to: (Date.parse(params[:date_to]) rescue nil)
            )
  end

  def place_helper(type)
    @items = Menu.where(import_id: params[:id]).select(type).distinct.order(type).pluck(type)
    @filter = type
    render :places
  end
end
