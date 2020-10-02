class LocationService < ApplicationService

  attr_reader :errors

  def initialize(params, location)
    @errors = []
    @params = params
    @location = location
  end

  def call
    country_name = @params[:country_name]
    country_alias = @params[:country_alias]
    state_name = @params[:state_name]
    city_name = @params[:city_name]

    if country_name.present? ||
      country_alias.present? ||
      state_name.present? ||
      city_name.present?
      @errors << "#{city_name.to_read(true)} is empty"
    end

    if country_name.to_i == 0
      country = Country.create(name: country_name)
    else
      country ||= Country.find(country_name.to_i)
      if country_alias.to_i != 0
        country_alias = Country.find(country_alias.to_i)
        country.update_attributes(alias: country_alias.alias)
      end
    end

    if state_name.to_i == 0
      state = State.create(name: state_name, country_id: country.id)
    else
      state ||= State.find(state_name.to_i)
      state.update_attributes(country_id: country.id)
    end

    if city_name.to_i == 0
      city = City.create(name: city_name, state_id: state.id, country_id: country.id)
    else
      city ||= City.find(city_name.to_i)
      city.update_attributes(state_id: state.id, country_id: country.id)
    end

  end

end
