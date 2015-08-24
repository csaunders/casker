class Admin::ImportersController < ApplicationController
  helper_method :imports, :import, :event

  def index
  end

  def show
  end

  def create
    import = Import.new(create_import_params)
    cask_days = CaskDays.import(import.raw_data)
    import.processed_data = cask_days.to_hash
    import.save
    redirect_to admin_importer_path(import)
  end

  def update
  end

  def finalize
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

  def create_import_params
    import_params = params.permit(:name, :data)
    import_params[:raw_data] = import_params.delete(:data).read
    import_params[:processor] = "CaskDays"
    import_params
  end
end
