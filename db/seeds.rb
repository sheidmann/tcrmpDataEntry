# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# To empty and re-seed, use rake db:reset
User.create(name: "HEIDMANN_SARAH", username: "heidmann_sarah", 
	email: "sarah@heidmann.com", password: "heidmann_sarah", 
	agency: "UVI", active: "true", role: "admin")
User.create(name: "ENNIS_ROSMIN", username: "ennis_rosmin", 
	email: "rosmin@ennis.com", password: "ennis_rosmin", 
	agency: "UVI", active: "true", role: "manager")
User.create(name: "KADISON_SHAUN", username: "kadison_shaun", 
	email: "shaun@kadison.com", password: "kadison_shaun", 
	agency: "UVI", active: "true", role: "manager")
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

Site.create(site_name: "Buck Island STT", site_code: "BIT", island: "STT", 
	latitude: 18.27883, longitude: -64.89833, orientation: "midshelf",
	land: "island", reef_complex: "offshore", depth_m: 14)
Site.create(site_name: "Black Point", site_code: "BPT", island: "STT", 
	latitude: 18.3445, longitude: -64.98595, orientation: "nearshore", 
	land: "island", reef_complex: "nearshore", depth_m: 9)
Site.create(site_name: "Flat Cay", site_code: "FLC", island: "STT", 
	latitude: 18.31822, longitude: -64.99104, orientation: "midshelf",
	land: "island", reef_complex: "offshore", depth_m: 12)

SurveyType.create(type_name: "fish transect", category: "fish", units: "m")	
SurveyType.create(type_name: "fish rover", category: "fish", units: "min")	
SurveyType.create(type_name: "coral health", category: "benthic", units: "m")

Boatlog.create(site_id: Site.find_by(site_name: "Flat Cay").id, 
	date_completed: Date.parse("2020-05-08"), 
	begin_time: Time.parse("09:45Z"), 
	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)
BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
	user_id: User.find_by(name: "ENNIS_ROSMIN").id, 
	survey_type_id: SurveyType.find_by(type_name: "coral health").id, 
	rep: 1)
BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
	user_id: User.find_by(name: "BRANDTNERIS_VIKTOR").id,
	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
	rep: 2)
BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
	user_id: User.find_by(name: "HEIDMANN_SARAH").id,
	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
	rep: 1)

Boatlog.create(site_id: Site.find_by(site_name: "Black Point").id, 
	date_completed: Date.parse("2020-05-08"),
	begin_time: Time.parse("13:00Z"), 
	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)
BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
	user_id: User.find_by(name: "ENNIS_ROSMIN").id, 
	survey_type_id: SurveyType.find_by(type_name: "coral health").id, 
	rep: 1)
BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
	user_id: User.find_by(name: "HEIDMANN_SARAH").id,
	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
	rep: 1)


