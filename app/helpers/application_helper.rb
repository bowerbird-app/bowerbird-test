module ApplicationHelper
  include Pagy::Frontend

  def current_sort_by
    if params[:sort_by].present? and params[:sort_by] == 'desc'
      'desc'
    else
      'asc'
    end
  end

  def reverse_sort_by
    if params[:sort_by].present? and params[:sort_by] == 'desc'
      'asc'
    else
      'desc'
    end
  end
end
