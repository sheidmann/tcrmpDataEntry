FactoryBot.define do
  factory :admin, class: "User" do
    name { "DOE_JANE" }
    username { "doe_jane" }
    email { "jane@doe.com" }
    password { "doe_jane" }
    agency { "UVI" }
    active { "true" }
    role { "admin" }
  end

  factory :manager, class: "User" do
    name { "DOE_JACK" }
    username { "doe_jack" }
    email { "jack@doe.com" }
    password { "doe_jack" }
    agency { "UVI" }
    active { "true" }
    role { "manager" }
  end

  factory :user do
    name { "DOE_JOHN" }
    username { "doe_john" }
    email { "john@doe.com" }
    password { "doe_john" }
    agency { "UVI" }
    active { "true" }
    role { "user" }
  end

  factory :boatlog do
    site { "The Best Site" }
    date_completed { "2020-05-05" }
    begin_time { "10:00" }
    manager_name { "DOE_JACK" }
  end
end