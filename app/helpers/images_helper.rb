module ImagesHelper
  def current_selected_tag_id
    if params[:tag_id].present?
      params[:tag_id].to_i
    else
      nil
    end
  end

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

  def query_params
    # we only want the query params with value
    params.permit(:tag_id, :name, :sort_by).select { |k, v| v.present? }
  end
end
