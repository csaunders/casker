class Admin::DashboardController < AdminAreaController
  def index
    render text: 'This is the dashboard'
  end
end
