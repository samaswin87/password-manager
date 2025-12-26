class LocationService < ApplicationService
  attr_reader :errors

  def initialize(params)
    @errors = []
    @params = params
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

    country = country_name.to_i.zero? ? Country.create(name: country_name) : Country.find(country_name.to_i)
    country_alias = Country.find(country_alias.to_i).alias unless country_alias.to_i.zero?
    country.update(alias: country_alias)

    state = if state_name.to_i.zero?
              State.create(name: state_name,
                           country_id: country.id)
            else
              State.find(state_name.to_i)
            end
    city = if city_name.to_i.zero?
             City.create(name: city_name, state_id: state.id,
                         country_id: country.id)
           else
             City.find(city_name.to_i)
           end
    city.update(state_id: state.id, country_id: country.id)
    city
  end
end
