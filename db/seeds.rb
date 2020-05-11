# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# To empty and re-seed, use rake db:reset then rake db:seed
User.create(name: "HEIDMANN_SARAH", username: "heidmann_sarah", 
	email: "sarah@heidmann.com", password: "heidmann_sarah", 
	agency: "UVI", active: "true", role: "admin")
User.create(name: "ENNIS_ROSMIN", username: "ennis_rosmin", 
	email: "rosmin@ennis.com", password: "ennis_rosmin", 
	agency: "UVI", active: "true", role: "manager")
User.create(name: "KADISON_SHAUN", username: "kadison_shaun", 
	email: "shaun@kadison.com", password: "kadison_shaun", 
	agency: "UVI", active: "true", role: "user")
User.create(name: "BRANDTNERIS_VIKTOR", username: "brandtneris_viktor", 
	email: "viktor@brandtneris.com", password: "brandtneris_viktor", 
	agency: "UVI", active: "true", role: "user")
User.create(name: "SMITH_TYLER", username: "smith_tyler", 
	email: "tyler@smith.com", password: "smith_tyler", 
	agency: "UVI", active: "true", role: "user")
User.create(name: "BLONDEAU_JEREMIAH", username: "blondeau_jeremiah", 
	email: "jeremiah@blondeau.com", password: "blondeau_jeremiah", 
	agency: "NOAA", active: "true", role: "user")
Manager.create(user_id: User.find_by(name: "ENNIS_ROSMIN").id, project: "TCRMP")	
Boatlog.create(site: "Flat Cay", 
	date_completed: Date.parse("2020-05-08"), 
	begin_time: Time.parse("09:45Z"), 
	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)
Boatlog.create(site: "Black Point", 
	date_completed: Date.parse("2020-05-08"),
	begin_time: Time.parse("13:00Z"), 
	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)