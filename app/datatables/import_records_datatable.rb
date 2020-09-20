class ImportRecordsDatatable < ApplicationDatatable

  def_delegators :@view, :check_box_tag, :link_to, :resource_path, :content_tag, :concat

  def initialize(params, opts = {})
    @resource = opts[:resource]
    super
  end

  def custom_columns
    @resource.headers
  end

  def view_columns
    view_columns_hash = { id: { source: 'ImportDataTable.id', searchable: false } }
    custom_columns.each do |column|
      view_columns_hash[column.to_sym] = { source: 'ImportDataTable.#{column}', searchable: false, orderable: false }
    end
    @view_columns ||= view_columns_hash
  end

  def data
    records.map do |record|
      record_hash = {
        id:         record.id,
        DT_RowId:   record.id
      }
      custom_columns.each do |column|
        record_hash[column] = record.dynamic_fields[column]
      end

      record_hash
    end
  end

  def get_raw_records
    records = @resource.import_data_tables || []
    order = params.fetch('order', {})
    if order.present?
      column = params.fetch('columns', {}).fetch(order['0']['column'], {})
      records = records.order("dynamic_fields ->> '#{column['data']}' #{order['0']['dir']}")
    end

    search = params.fetch('search', {})
    if search && search['value'].present?
      record_ids = []
      custom_columns.each do |column_name|
        record_ids << records.where("dynamic_fields ->> '#{column_name}' LIKE ?", "%#{search['value']}%").map(&:id)
      end
      records = records.where('id IN (?)', record_ids.flatten.uniq)
    end

    records
  end

end
