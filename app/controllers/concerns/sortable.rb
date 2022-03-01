module Sortable
  include ActiveSupport::Concern

  def name_sortable(records)
    if params[:sort_by].present? and params[:sort_by] == 'desc'
      records = records.order(name: :desc)
    else
      records = records.order(name: :asc)
    end
  end

end