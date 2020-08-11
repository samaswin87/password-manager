class Address < ActiveRecord::Base
  # ---- relationships ----

  belongs_to :linkable, polymorphic: true
  belongs_to :city
  belongs_to :state

  # ---- delegates ----

  delegate :name, to: :city, prefix: true, allow_nil: true
  delegate :name, to: :state, prefix: true, allow_nil: true
end
