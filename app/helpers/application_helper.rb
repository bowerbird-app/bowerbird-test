module ApplicationHelper
  def alert_mappings
    {
      alert: 'warning',
      error: 'error',
      notice: 'info',
      success: 'success'
    }
  end
end
