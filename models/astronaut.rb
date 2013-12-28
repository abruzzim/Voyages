class Astronaut < ActiveRecord::Base
  # Many "planets" table rows reference Astronaut.
  has_many :planets
  # Many "moons" table rows reference Astronaut.
  has_many :moons
end