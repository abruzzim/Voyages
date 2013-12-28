class Planet < ActiveRecord::Base
  has_many :moons
  belongs_to :astronauts
end