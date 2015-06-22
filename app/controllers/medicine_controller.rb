class MedicineController < ApplicationController
  before_action :find_or_create_cabinet, except: :search
  def index
  end

  def search
    response = OpenFda::Client.new.query_by_med_name(params[:search_input], 100, skip_per_page(params[:page].to_i)).body
    results = JSON.parse(response)['results'].to_a
    @display_results = !results.any? ? [] : results.map do |med|
      next if med['openfda']['brand_name'].nil?
      { brand_name: med['openfda']['brand_name'].first.titleize, set_id: med['set_id'] }
    end.flatten.compact

    respond_to do |format|
      format.json { render json: @display_results.to_json }
      format.html { @display_results }
    end
  end

  def autocomplete
    render json: SearchableMedicine.all.map(&:name)
  end

  def cabinet
  end

  def add_to_cabinet
    @cabinet.add_to_cabinet(medicine_params)
  end

  private

  def medicine_params
    params.require(:medicine).permit(:name, :set_id)
  end

  def skip_per_page(page = 0)
    page * Kaminari.config.default_per_page
  end

  def find_or_create_cabinet
    if session[:cabinet_id].nil?
      @cabinet = Cabinet.create!
      session[:cabinet_id] = @cabinet.id
    else
      @cabinet = Cabinet.find_by_id(session[:cabinet_id])
    end
  end
end
