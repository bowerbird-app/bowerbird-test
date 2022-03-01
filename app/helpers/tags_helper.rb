module TagsHelper
  def query_params
    # we only want the query params with value
    params.permit!.slice(:name, :sort_by).select { |k, v| v.present? }
  end
end
