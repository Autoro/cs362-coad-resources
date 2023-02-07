FactoryBot.define do
    factory :organization do
        name { "Test Company" }
        status { :submitted }
        phone { "555-555-5555" }
        email { "test@company.com" }
        description { "A test company." }
        primary_name { "Primary Name" }
        secondary_name { "Secondary Name" }
        secondary_phone { "555-555-5555" }
        title { "Title" }
        transportation { "yes" }
    end
end