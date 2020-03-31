class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # TODO: your code here
    #{'1' => ['Joan Lee', 'Charlie McDonald', 'Kevin Quashie'], '2' => ['Ed Michaels', 'Lisa Frank', 'Sharla Alegria']}
    ao_object = self.buses.joins(:drivers).select('buses.*','drivers.*')
    drivers = Hash.new { |hash, key| hash[key] = [] }
    ao_object.each do |ele|
      drivers[ele.bus_id] << ele.name
    end
    drivers
  end
end
