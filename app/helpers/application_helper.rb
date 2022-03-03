module ApplicationHelper
  include Pagy::Frontend

  def alert_mappings
    {
      alert: 'warning',
      error: 'error',
      notice: 'info',
      success: 'success'
    }
  end
end
