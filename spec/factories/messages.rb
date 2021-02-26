# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    user { create(:user) }
    body { Faker::Lorem.words }
  end
end
