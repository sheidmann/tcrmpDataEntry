# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# To empty and re-seed, use rake db:reset

# Manager.create(user_id: User.find_by(name: "ENNIS_ROSMIN").id, project: "TCRMP")

# Site.create(site_name: "Buck Island STT", site_code: "BIT", island: "STT", 
# 	latitude: 18.27883, longitude: -64.89833, orientation: "midshelf",
# 	land: "island", reef_complex: "offshore", depth_m: 14)
# Site.create(site_name: "Black Point", site_code: "BPT", island: "STT", 
# 	latitude: 18.3445, longitude: -64.98595, orientation: "nearshore", 
# 	land: "island", reef_complex: "nearshore", depth_m: 9)
# Site.create(site_name: "Flat Cay", site_code: "FLC", island: "STT", 
# 	latitude: 18.31822, longitude: -64.99104, orientation: "midshelf",
# 	land: "island", reef_complex: "offshore", depth_m: 12)

# SurveyType.create(type_name: "fish transect", category: "fish", units: "m")	
# SurveyType.create(type_name: "fish rover", category: "fish", units: "min")	
# SurveyType.create(type_name: "coral health", category: "benthic", units: "m")

# Boatlog.create(site_id: Site.find_by(site_name: "Flat Cay").id, 
# 	date_completed: Date.parse("2020-05-08"), 
# 	begin_time: Time.parse("09:45Z"), 
# 	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)
# BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
# 	user_id: User.find_by(name: "ENNIS_ROSMIN").id, 
# 	survey_type_id: SurveyType.find_by(type_name: "coral health").id, 
# 	rep: 1)
# BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
# 	user_id: User.find_by(name: "BRANDTNERIS_VIKTOR").id,
# 	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
# 	rep: 2)
# BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
# 	user_id: User.find_by(name: "HEIDMANN_SARAH").id,
# 	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
# 	rep: 1)

# Boatlog.create(site_id: Site.find_by(site_name: "Black Point").id, 
# 	date_completed: Date.parse("2020-05-08"),
# 	begin_time: Time.parse("13:00Z"), 
# 	manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id)
# BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
# 	user_id: User.find_by(name: "ENNIS_ROSMIN").id, 
# 	survey_type_id: SurveyType.find_by(type_name: "coral health").id, 
# 	rep: 1)
# BoatlogSurvey.create(boatlog_id: Boatlog.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
# 	user_id: User.find_by(name: "HEIDMANN_SARAH").id,
# 	survey_type_id: SurveyType.find_by(type_name: "fish transect").id,
# 	rep: 1)

FishTransect.create(manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id, 
	site_id: Site.find_by(site_name: "Flat Cay").id, user_id: User.find_by(name: "HEIDMANN_SARAH").id, 
	date_completed: Date.parse("2020-08-19"),begin_time: Time.parse("13:00Z"), rep: 1, completed_m: 25, oc_cc: "OC")
TransectFish.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
	fish_id: Fish.find_by(common_name: "striped parrotfish").id, 
	x0to5: 10, x6to10: 2, x11to20: 5, x21to30: 1, x31to40: 0, xgt40: 0)
TransectFish.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id,
	fish_id: Fish.find_by(common_name: "mutton snapper").id, 
	x0to5: 0, x6to10: 0, x11to20: 0, x21to30: 0, x31to40: 0, xgt40: 1)
Diadema.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id, test_size_cm: 11)
Diadema.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Flat Cay").id).id, test_size_cm: 13)

FishTransect.create(manager_id: Manager.find_by(user_id: User.find_by(name: "ENNIS_ROSMIN").id).id, 
	site_id: Site.find_by(site_name: "Black Point").id, user_id: User.find_by(name: "HEIDMANN_SARAH").id, 
	date_completed: Date.parse("2020-08-19"),begin_time: Time.parse("14:15Z"), rep: 1, completed_m: 25, oc_cc: "OC")
TransectFish.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
	fish_id: Fish.find_by(common_name: "threespot damselfish").id, 
	x0to5: 2, x6to10: 4, x11to20: 0, x21to30: 0, x31to40: 0, xgt40: 0)
TransectFish.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
	fish_id: Fish.find_by(common_name: "mutton snapper").id, 
	x0to5: 0, x6to10: 0, x11to20: 0, x21to30: 0, x31to40: 0, xgt40: 1)
TransectFish.create(fish_transect_id: FishTransect.find_by(site_id: Site.find_by(site_name: "Black Point").id).id,
	fish_id: Fish.find_by(common_name: "blue chromis").id, 
	x0to5: 20, x6to10: 30, x11to20: 0, x21to30: 0, x31to40: 0, xgt40: 0)


