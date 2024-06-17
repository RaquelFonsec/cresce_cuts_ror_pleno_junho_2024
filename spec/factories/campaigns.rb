
FactoryBot.define do
    factory :campaign do
      association :user
      association :product
      description { "Sample Campaign" }
      start_date { Date.today }
      end_date { Date.today + 1.month }
      status { :ativo }
      
      after(:build) do |campaign|
        campaign.discount ||= build(:discount, user: campaign.user)
      end
    end
  
    factory :discount do
      discount_type { "percentage" }
      discount_value { 10 }
      association :user
    end
    
    factory :product do
      name { "Sample Product" }
      price { 100 }
    end
  
    factory :user do
      email { "user@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end
  end
  