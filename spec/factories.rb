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
  
end