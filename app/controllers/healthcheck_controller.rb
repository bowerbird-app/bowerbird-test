class HealthcheckController < ActionController::Base

  def index
    render json: {
      status: 'ok',
      message: 'App is working'
    }, status: 200
  end

end