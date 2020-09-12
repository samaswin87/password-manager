class FieldMappingDecorator < Draper::Decorator
  delegate_all

  def supported_tables
    [:passwords, :users, :state, :city]
  end

  def columns(table)
    columns = []
    klass_name = table.camelize.singularize(:en)
    if klass_name.constantize
      columns = klass_name.constantize.column_names
    end
    columns
  end

end
