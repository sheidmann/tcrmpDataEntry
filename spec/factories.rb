FactoryBot.define do
  factory :admin, class: "User" do
    name { "DOE_JOHN" }
    username { "doe_john" }
    email { "john@doe.com" }
    password { "doe_john" }
    agency { "UVI" }
    active { "true" }
    role { "admin" }
  end

  factory :manager, class: "User" do
    name { "DOE_JOHN" }
    username { "doe_john" }
    email { "john@doe.com" }
    password { "doe_john" }
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
end