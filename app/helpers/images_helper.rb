module ImagesHelper
  def current_selected_tag_id
    if params[:tag_id].present?
      params[:tag_id].to_i
    else
      nil
    end
  end

  def query_params
    # we only want the query params with value
    params.slice(:tag_id, :name, :sort_by).select { |k, v| v.present? }
  end
end
