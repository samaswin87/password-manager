module CsvRowValidator
  extend ActiveSupport::Concern

  class_methods do
    def csv_row_validate(params = {})
      @field_maps = params
      include CsvRowValidator::InstanceMethods
    end

    def field_maps
      @field_maps
    end
  end

  module InstanceMethods
    def validate_fields(row)
      field_errors = []
      if self.class.field_maps[:blank].present?
        self.class.field_maps[:blank].each do |field|
          field_errors << "#{field.to_s.humanize} must not be blank" if row.keys.include?(field) && row[field].blank?
        end
      end

      if self.class.field_maps[:email].present?
        self.class.field_maps[:email].each do |field|
          field_errors << "#{field.to_s.humanize} must be valid email format" if row.keys.include?(field) && (URI::MailTo::EMAIL_REGEXP =~ row[field].to_s).nil?
        end
      end

      if self.class.field_maps[:number].present?
        self.class.field_maps[:number].each do |field|
          field_errors << "#{field.to_s.humanize} must be valid number" if row.keys.include?(field) && !row[field].to_s.is_number?
        end
      end

      @errors << field_errors if field_errors.present?
      field_errors.blank?
    end
  end

end
