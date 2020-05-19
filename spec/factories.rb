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

  factory :boatlog do
    site { "The Best Site" }
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

  
end