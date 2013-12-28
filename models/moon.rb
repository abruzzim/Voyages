class Moon < ActiveRecord::Base
  # A Moon references a "planets" table row.
  belongs_to :planets # ?
  # A Moon references an "astronauts" table row.
  belongs_to :astronauts # ?
end