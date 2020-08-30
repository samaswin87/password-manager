#   Column   |            Type             | Collation | Nullable |               Default
# ------------+-----------------------------+-----------+----------+-------------------------------------
#  id         | bigint                      |           | not null | nextval('genders_id_seq'::regclass)
#  name       | character varying           |           |          |
#  alias      | character varying           |           |          |
#  created_at | timestamp without time zone |           | not null |
#  updated_at | timestamp without time zone |           | not null |
class Gender < ApplicationRecord

  def self.find_gender(value)
    if %w(Male Female male female).include?(value)
      Gender.find_by(alias: value.downcase)
    elsif %w(m f M F).include?(value)
      gender_name = (value.downcase == 'm') ? 'Male' : 'Female'
      Gender.find_by(alias: gender_name)
    elsif value
      Gender.find_by(alias: 'male')
    else
      Gender.find_by(alias: 'female')
    end
  end
end
