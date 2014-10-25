class DrinksController < ApplicationController
  before_action { activate(:drinks) }

  def index
    @drinks = attendee.drinks
    @complete, @incomplete = @drinks.group_by{|d| d.done?}.map{|k, v| v}
  end

  def show
    if drink.blank?
      flash[:notice] = "Could not find entry"
      redirect_to drinks_path
    end
  end

  def create
    drink = attendee.drinks.where(cask_id: drink_params[:cask_id]).first_or_initialize
    drink.update_attributes(drink_params)
    flash[:notice] = "Added #{drink.name} by #{drink.brewery} to your list" if drink.save
    redirect_to(return_path || drink_path(drink))
  end

  def destroy
    drink.destroy if drink.present?
    flash[:notice] = "Removed #{drink.cask.name} from your drink list"
    redirect_to drinks_path
  end

  def toggle_favourite
    if drink.present?
      drink.favourite = !drink.favourite
      set_notice('favourite')
    end
    redirect_to(return_path || drink_path(drink))
  end

  def toggle_complete
    if drink.present?
      drink.done = !drink.done
      set_notice('completion')
    end
    redirect_to(return_path || drink_path(drink))
  end

  private

  def set_notice(type)
    flash[:notice] = "Updated #{type} status on #{drink.name} #{drink.style}" if drink.save
  end

  def drink_params
    params.require(:drink).permit(:cask_id, :favourite, :done)
  end

  def drink
    @drink ||= attendee.drinks.find_by(id: params[:id])
  end
end
