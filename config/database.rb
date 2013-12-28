ActiveRecord::Base.establish_connection(
  adapter:  "postgresql",
  host:     "localhost",
  username: "abruzzim", # ENV [PG_USER]
  database: "nasa_db",
  encoding: "utf8"
)