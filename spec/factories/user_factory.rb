FactoryBot.define do
    factory :user do
        role { :organization }
        email { generate(:email) }
        password { "password" }

        trait :admin do
            role { :admin }
        end

        trait :confirmed do
            confirmed_at { Date.today }
        end
    end
end