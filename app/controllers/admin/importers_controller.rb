class Admin::ImportersController < AdminAreaController
  helper_method :imports, :import, :event

  skip_before_action :require_admin, only: [:show, :update]
  before_action :require_collaborator, only: [:show, :update]

  def create
    import = Import.new(create_import_params)
    cask_days = CaskDays.import(import.raw_data)
    import.processed_data = cask_days.to_hash
    import.save
    redirect_to admin_importer_path(import)
  end

  def update
    import.processed_data = {
      festival: festival_data,
      breweries: brewery_data,
      beer_styles: beer_style_data,
      beers: beer_data
    }
    import.save
    redirect_to admin_importer_path(import)
  end

  def finalize
    redirect_to admin_imports_path if import.completed?
    ActiveRecord::Base.transaction do
      event = CaskDays.new(import.processed_data)
      event.finalize!
      import.mark_as_complete
    end
  end

  private
  def imports
    @imports ||= Import.all
  end

  def import
    @import ||= Import.find(params[:id])
  end

  def event
    @event ||= import.processor.constantize.new(import.processed_data)
  end

  def festival_data
    params.require(:festival).permit(:name, :description, :starts_at, :ends_at, :website, :address, :latitude, :longitude).to_hash
  end

  def brewery_data
    params.require(:breweries).map do |brewery|
      brewery.slice(:name, :website, :tagline, :signature, :location_signature).to_hash
    end
  end

  def beer_style_data
    params.require(:beer_styles).map { |style| style.slice(:name, :signature).to_hash }
  end

  def beer_data
    params.require(:beers).map do |beer|
      beer[:meta] = JSON.parse(beer[:meta])
      beer.slice(:name, :abv, :meta, :style_signature, :brewery_signature, :location_signature).to_hash
    end
  end

  def create_import_params
    import_params = params.permit(:name, :data)
    import_params[:raw_data] = import_params.delete(:data).read
    import_params[:processor] = "CaskDays"
    import_params
  end

  def require_collaborator
    return if current_user.admin?
    return if current_user.collaborator?
    render_404
  end
end
