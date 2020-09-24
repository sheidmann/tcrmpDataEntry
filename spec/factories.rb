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
    xgt40 { 0 }
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

  # factory :rover_fish do
  #   association :fish_rover, factory: :fish_rover
  #   association :fish, factory: :fish
  #   abundance_index { 1 }
  # end

  
end