class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root_path

  private
    def redirect_to_root_path
      flash[:error] = 'Record does not exist'
      redirect_to root_path
    end
end
