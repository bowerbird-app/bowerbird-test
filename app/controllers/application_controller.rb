class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Sortable
  
  before_action :authenticate_user!
end
