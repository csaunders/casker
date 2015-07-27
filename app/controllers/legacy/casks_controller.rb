module Legacy
  class CasksController < ApplicationController
    before_action { activate(:casks) }

    def index
      @casks = Cask.where(cask_params).page params[:page]
    end

    def show
      unless @cask = Cask.find_by(id: params[:id])
        flash[:error] = "Invalid Cask ID"
        redirect_to casks_path
      end
    end

    private
    def cask_params
      params.permit(:region, :style)
    end
  end
end
