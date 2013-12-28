require "sinatra"
require "active_record"
require "sinatra/activerecord"
require "sinatra/activerecord/rake"

require_relative "config/database"

require_relative 'models/astronaut'
require_relative 'models/planet'
require_relative 'models/moon'
require_relative 'models/voyage'

namespace :db do
  desc "Seed Empty nasa_db Database"
  task :seed do
    astronaut1 = Astronaut.create(fname: "Neil", lname: "Armstrong", imgsrc: "http://www.biography.com/imported/images/Biography/Images/Profiles/A/Neil-Armstrong-9188943-2-402.jpeg")
    astronaut2 = Astronaut.create(fname: "Buzz", lname: "Aldrin", imgsrc: "http://4.bp.blogspot.com/_uXMqgRJz0uI/TNr5PZQQG0I/AAAAAAAABP0/CKpqSWjqeqQ/s1600/Buzz-Aldrin.jpg")
    astronaut3 = Astronaut.create(fname: "Scott", lname: "Campbell", imgsrc: "http://www.examiner.com/images/blog/wysiwyg/image/astronaut(4).jpg")
    planet1 = Planet.create(:name => "Earth")
    planet2 = Planet.create(:name => "Mars")
    moon1 = Moon.create(:name => "The Moon")
    moon2 = Moon.create(:name => "Phobos")
    voyage1 = Voyage.create(:astronaut_id => 1, :planet_id => 1, :moon_id => 1)
    voyage2 = Voyage.create(:astronaut_id => 2, :planet_id => 1, :moon_id => 1)
    voyage3 = Voyage.create(:astronaut_id => 3, :planet_id => 2, :moon_id => 2)
  end
end
