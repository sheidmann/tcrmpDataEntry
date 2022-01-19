FactoryBot.define do

  factory :user do
    name { "DOE_JOHN" }
    username { "#{name.downcase}" if name}
    email { "#{name.split('_')[1]}@#{name.split('_')[0]}.com" if name }
    password { "#{name.downcase}" if name }
    agency { "UVI" }
    active { "true" }
    role { "user" }
  end

  factory :manager, parent: :user do
    name {"DOE_JACK"}
    role { "manager" }
  end

  factory :admin, parent: :user do
    name { "DOE_JANE" }
    role { "admin" }
  end

  factory :boatlog_manager, class: "Manager" do
    project { "My Project" }
    association :user, factory: :manager
  end

  factory :site do
    site_name { "The Best Site" }
  end

  factory :boatlog do
    association :site, factory: :site
    date_completed { Date.parse("2020-05-05") }
    begin_time { Time.parse("10:00Z") }
    association :manager, factory: :boatlog_manager
  end

  factory :survey_type do
    type_name { "Special Survey"}
    category { "benthic" }
    units { "meters" }
  end

  factory :boatlog_survey do
    association :boatlog, factory: :boatlog
    association :user, factory: :user
    association :survey_type, factory: :survey_type
    rep { 1 }
  end

  factory :fish do
    common_name { "the coolest fish" }
    scientific_name { "Coolus fishus" }
    code_name { "COO FISH" }
    family { "Coolidae" }
    troph { "apex" }
    commercial { "Y" }
    min_size { 10 }
    max_size { 50 }
    max_num { 1 }
  end

  factory :fish_transect do
    association :manager, factory: :boatlog_manager
    association :site, factory: :site
    association :user, factory: :user
    date_completed { Date.parse("2020-05-05") }
    begin_time { Time.parse("10:00Z") }
    oc_cc { "OC" }
    rep { 1 }
    completed_m { 25 }
  end

  factory :transect_fish do
    association :fish_transect, factory: :fish_transect
    association :fish, factory: :fish
    x0to5 { 5 }
    x6to10 { 3 }
    x11to20 { 2 }
    x21to30 { 1 }
    x31to40 { 0 }
    x41to50 { 0 }
    x51to60 { 0 }
    x61to70 { 0 }
    x71to80 { 0 }
    x81to90 { 0 }
    x91to100 { 0 }
    x101to110 { 0 }
    x111to120 { 0 }
    x121to130 { 0 }
    x131to140 { 0 }
    x141to150 { 0 }
    xgt150 { 0 }
  end

  factory :diadema do
    association :fish_transect, factory: :fish_transect
    test_size_cm { 10 }
  end

  factory :fish_rover do
    association :manager, factory: :boatlog_manager
    association :site, factory: :site
    association :user, factory: :user
    date_completed { Date.parse("2020-05-05") }
    begin_time { Time.parse("10:00Z") }
    oc_cc { "OC" }
    rep { 1 }
  end

  factory :rover_fish do
    association :fish_rover, factory: :fish_rover
    association :fish, factory: :fish
    abundance_index { 1 }
  end

  factory :algae do
    code_name { "ALG" }
    full_name { "wavy plant stuff" }
  end

  factory :algae_height do
    association :manager, factory: :boatlog_manager
    association :site, factory: :site
    association :user, factory: :user
    date_completed { Date.parse("2021-01-05") }
    rep { 1 }
  end

  factory :transect_algae do
    association :algae_height, factory: :algae_height
    association :algae, factory: :algae
    height_cm { 2.5 }
  end

  factory :coral, class: "CoralCode" do
    code_name { "CC" }
    group { "Identification" }
    category { "Coral" }
    full_name { "Coolus coralus" }
  end
  
  factory :interaction, class: "CoralCode" do
    code_name { "RS" }
    group { "Interaction" }
    category { "Sponge" }
    full_name { "rude sponge" }
  end

  factory :coral_health do
    association :manager, factory: :boatlog_manager
    association :site, factory: :site
    association :user, factory: :user
    date_completed { Date.parse("2021-01-15") }
    rep { 1 }
  end

  factory :transect_coral do
    association :coral_health, factory: :coral_health
    association :coral_code, factory: :coral
    length_cm { 7 }
    width_cm { 5 }
    height_cm { 2 }
  end

  factory :coral_interaction do
    association :transect_coral, factory: :transect_coral
    association :coral_code, factory: :interaction
    value { 5 }
  end
end