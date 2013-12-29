=begin
 Filename: main.rb
 Directory: /Users/abruzzim/Documents/ga_wdi/projects/planets
 Author: Mario Abruzzi
 Date: Thu Dec 26 16:23:41 EST 2013
 Desc: Week 0 - Day 0 - HW
 Notes: Starts Sinatra listening on port 4567
=end

# Configure the load path so all dependencies
# in the Gemfile can be required. Only Gems from
# specified groups will be added.

require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

# Ruby Dependency Manager

##require 'bundler/setup'

# Require all the Gems in the Gemfile.

##Bundler.require(:default)

# Enable PSQL (debug) command logging.

ActiveRecord::Base.logger = Logger.new(STDOUT)

# Configure the Database

require_relative 'config/database'

require_relative 'models/astronaut'
require_relative 'models/planet'
require_relative 'models/moon'
require_relative 'models/voyage'
##require_relative 'specs/'
##require_relative 'views/'

# Configuration Settings

set :dbg, 'true'

# Sinatra GET Default Route

get '/' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET Default (/) Route" 
    p "  %DEBUG-I-MAINRB, GET '/' Route Params Hash Keys: #{params.keys}"
    p "  %DEBUG-I-MAINRB, GET '/' Route Params Hash Values: #{params.values}"
  end
  # Initialize array.
  @voyage_list = []
  # Get ActiveRecord::Relation Object.
  Voyage.all.each do |voyage|
    # Initialize hash.
    trip   = {}
    vid    = voyage.id
    fname  = Astronaut.find(voyage.astronaut_id).fname
    lname  = Astronaut.find(voyage.astronaut_id).lname
    name   = "#{fname} #{lname}"
    planet = Planet.find(voyage.planet_id).name
    moon   = Moon.find(voyage.moon_id).name
    trip   = {vid: vid, name: name, planet: planet, moon: moon}
    # Add hash to array.
    @voyage_list << trip
  end
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')
  # Call view.
  erb :index
end

# Sinatra GET /voyages_add_1 Route

get '/voyages_add_1' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /voyages_add_1 Route" 
    p "  %DEBUG-I-MAINRB, GET '/voyages_add_1' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/voyages_add_1' Route Params Hash Values: #{params.values}" 
  end
  # Get all Table Rows or ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')
  @planet_list    = Planet.all.order('name')
  # Call view - Display astronaut and planet choices.
  erb :voyages_1
end

# Sinatra GET /voyages_add_2 Route

get '/voyages_add_2' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /voyages_add_2 Route" 
    p "  %DEBUG-I-MAINRB, GET '/voyages_add_2' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/voyages_add_2' Route Params Hash Values: #{params.values}" 
  end
  # Get specific astronaut object.
  astronaut       = Astronaut.find(params[:astronaut_id])
  @astronaut_id   = astronaut.id
  @astronaut_name = "#{astronaut.fname} #{astronaut.lname}"
  # Get specific planet object.
  planet          = Planet.find(params[:planet_id])
  @planet_id      = planet.id
  @planet_name    = planet.name
  # Get all Table Rows for the selcted Planet.
  @moon_list      = Moon.where(planet_id: planet.id)
  p @astronaut_id
  p @astronaut_name
  p @planet_id
  p @planet_name
  p @moon_list
  # Call view - Display moon choices.
  erb :voyages_2
end

# Sinatra POST /voyages_add Route (incomplete)

post '/voyages_add' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /voyages_add Route" 
    p "  %DEBUG-I-MAINRB, POST '/voyages_add' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/voyages_add' Route Params Hash Values: #{params.values}" 
  end
  # Build object constructor.
  v = Voyage.new
  v.astronaut_id = params[:astronaut_id]
  v.planet_id    = params[:planet_id]
  v.moon_id      = params[:moon_id]
  # Insert object into database table.
  v.save!
  # Return to Main Page.
  redirect '/'
end

# Sinatra GET /astronauts Route

get '/astronauts' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /astronauts Route" 
    p "  %DEBUG-I-MAINRB, GET '/astronauts' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/astronauts' Route Params Hash Values: #{params.values}" 
  end
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')
  # Print a sorted list of methods on the console.
  ## @astronaut_list.methods.sort.each do |method|
  ##   p "  #{method}"
  ## end
  # Call view.
  erb :astronauts
end

# Sinatra POST /astronauts_add Route

post '/astronauts_add' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /astronauts_add Route" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_add' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_add' Route Params Hash Values: #{params.values}" 
  end
  # Build object constructor.
  astronaut = Astronaut.new
  astronaut.fname  = params[:fname]
  astronaut.lname  = params[:lname]
  astronaut.imgsrc = params[:imgsrc]
  # Insert object into database table.
  astronaut.save!
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')
  # Return to Astronauts Page.
  erb :astronauts
end

# Sinatra GET /astronauts_edit

get '/astronauts_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /astronauts_edit Route" 
    p "  %DEBUG-I-MAINRB, GET '/astronauts_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/astronauts_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific astronaut object.
  orig_astronaut = Astronaut.find(params[:astronaut_id])
  # Define instance variables of fields to be updated.
  @orig_astronaut_id     = orig_astronaut.id
  @orig_astronaut_fname  = orig_astronaut.fname
  @orig_astronaut_lname  = orig_astronaut.lname
  @orig_astronaut_imgsrc = orig_astronaut.imgsrc
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')  
  # Return to Astronauts Page for edit operation.
  erb :astronauts
end

# Sinatra POST /astronauts_edit

post '/astronauts_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /astronauts_edit Route" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific astronaut object.
  upd_astronaut = Astronaut.find(params[:upd_astronaut_id])
  # Updated object attributes.
  upd_astronaut.fname  = params[:upd_astronaut_fname]
  upd_astronaut.lname  = params[:upd_astronaut_lname]
  upd_astronaut.imgsrc = params[:upd_astronaut_imgsrc]
  # Insert row into database table.
  upd_astronaut.save!
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')  
  # Return to Astronauts Page.
  erb :astronauts
end

# Sinatra POST /astronauts_del Route

post '/astronauts_del' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /astronauts_del Route" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_del' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/astronauts_del' Route Params Hash Values: #{params.values}" 
  end
  # Build object destructor.
  Astronaut.delete(params[:astronaut_id])
  # Get all ActiveRecord::Relation Objects.
  @astronaut_list = Astronaut.all.order('lname')
  # Return to Astronauts Page.
  erb :astronauts
end

# Sinatra GET /planets Route

get '/planets' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /planets Route" 
    p "  %DEBUG-I-MAINRB, GET '/planets' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/planets' Route Params Hash Values: #{params.values}" 
  end
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Call view.
  erb :planets
end

# Sinatra POST /planets_add Route

post '/planets_add' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /planets_add Route" 
    p "  %DEBUG-I-MAINRB, POST '/planets_add' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/planets_add' Route Params Hash Values: #{params.values}" 
  end
  # Build object constructor.
  planet = Planet.new
  planet.name  = params[:name]
  # Insert object into database table.
  planet.save!
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')  
  # Return to Planets Page.
  erb :planets
end

# Sinatra GET /planets_edit

get '/planets_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /planets_edit Route" 
    p "  %DEBUG-I-MAINRB, GET '/planets_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/planets_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific planet object.
  orig_planet = Planet.find(params[:planet_id])
  # Define instance variables.
  @orig_planet_id   = orig_planet.id
  @orig_planet_name = orig_planet.name
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')  
  # Return to Planets Page for edit operation.
  erb :planets
end

# Sinatra POST /planets_edit

post '/planets_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /planets_edit Route" 
    p "  %DEBUG-I-MAINRB, POST '/planets_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/planets_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific planet object.
  upd_planet = Planet.find(params[:upd_planet_id])
  # Update object attribute.
  upd_planet.name = params[:upd_planet_name]
  # Insert row into database table.
  upd_planet.save!
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')  
  # Return to Planets Page.
  erb :planets
end

# Sinatra POST /planets_del Route

post '/planets_del' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /planets_del Route" 
    p "  %DEBUG-I-MAINRB, POST '/planets_del' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/planets_del' Route Params Hash Values: #{params.values}" 
  end
  # Build object destructor.
  Planet.delete(params[:planet_id])
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')  
  # Return to Astronauts Page.
  erb :planets
end

# Sinatra GET /moons Route

get '/moons' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /moons Route" 
    p "  %DEBUG-I-MAINRB, GET '/moons' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/moons' Route Params Hash Values: #{params.values}" 
  end
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Get all ActiveRecord::Relation Objects.
  @moon_list = Moon.all.order('name')
  # Call view.
  erb :moons
end

# Sinatra POST /moons_add Route

post '/moons_add' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /moons_add Route" 
    p "  %DEBUG-I-MAINRB, POST '/moons_add' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/moons_add' Route Params Hash Values: #{params.values}" 
  end
  # Build object constructor.
  moon           = Moon.new
  moon.name      = params[:name]
  moon.planet_id = params[:planet_id]
  # Insert object into database table.
  moon.save!
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Get all ActiveRecord::Relation Objects.
  @moon_list = Moon.all.order('name')  
  # Return to Planets Page.
  erb :moons
end

# Sinatra GET /moons_edit

get '/moons_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra GET /moons_edit Route" 
    p "  %DEBUG-I-MAINRB, GET '/moons_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, GET '/moons_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific moon object.
  orig_moon = Moon.find(params[:moon_id])
  # Define instance variables.
  @orig_moon_id     = orig_moon.id
  @orig_moon_name   = orig_moon.name
  @orig_planet_id   = orig_moon.planet_id
  if @orig_planet_id
    @orig_planet_name = Planet.find(@orig_planet_id).name
  else
    @orig_planet_name = nil
  end
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Get all ActiveRecord::Relation Objects.
  @moon_list = Moon.all.order('name')  
  # Return to Moons Page for edit operation.
  erb :moons
end

# Sinatra POST /moons_edit

post '/moons_edit' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /moons_edit Route" 
    p "  %DEBUG-I-MAINRB, POST '/moons_edit' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/moons_edit' Route Params Hash Values: #{params.values}" 
  end
  # Get specific moon object.
  upd_moon = Moon.find(params[:upd_moon_id])
  # Update object attributes.
  upd_moon.name      = params[:upd_moon_name]
  upd_moon.planet_id = params[:upd_planet_id]
  # Insert row into database table.
  upd_moon.save!
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Get all ActiveRecord::Relation Objects.
  @moon_list = Moon.all.order('name')
  # Return to Moons Page.
  erb :moons
end

# Sinatra POST /moons_del Route

post '/moons_del' do
  if settings.dbg == 'true'
    p "  %DEBUG-I-MAINRB, In Sinatra POST /moons_del Route" 
    p "  %DEBUG-I-MAINRB, POST '/moons_del' Route Params Hash Keys: #{params.keys}" 
    p "  %DEBUG-I-MAINRB, POST '/moons_del' Route Params Hash Values: #{params.values}" 
  end
  # Build object destructor.
  Moon.delete(params[:moon_id])
  # Get all ActiveRecord::Relation Objects.
  @planet_list = Planet.all.order('name')
  # Get all ActiveRecord::Relation Objects.
  @moon_list = Moon.all.order('name')  
  # Return to Moons Page.
  erb :moons
end
