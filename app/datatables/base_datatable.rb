class BaseDatatable

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: total_records,
      iTotalDisplayRecords: collection.total_entries,
      aaData: data
    }
  end

  protected

  def total_records
    table_name.singularize.classify.constantize.count
  end

  def table_name
    self.class.name.underscore.gsub(/_datatable$/, '')
  end

  def collection
    @collection ||= fetch_collection
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column(sphinx=false)
    columns = @columns || []
    column_name = columns[params[:iSortCol_0].to_i]

    if sphinx
      if column_name =~ /#{table_name}/
        column_name.gsub!(/#{table_name}\./, '')
      else
        column_name.gsub!(/\.name/, '')
      end
    end

    column_name
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end
