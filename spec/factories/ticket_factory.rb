include TicketsHelper

FactoryBot.define do
    factory :ticket do
        name { "Test Ticket" }
        description { "A test ticket." }
        phone { format_phone_number("555-555-5555") }
    end
end