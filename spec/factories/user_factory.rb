FactoryBot.define do
    factory :user do
        email { "test@test.com" }
        password { "password" }

        trait :confirmed do
            confirmed_at { Date.today }
        end

        trait :admin do
            role { :admin }
        end
    end
end