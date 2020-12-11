# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n+rand(30000000)}@factory.com" }
    password { "123456" }
  end
end
