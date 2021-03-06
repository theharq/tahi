require 'securerandom'

FactoryGirl.define do
  factory :invitation do
    code { SecureRandom.hex(4) }
    association(:task, factory: :task)
    association(:invitee, factory: :user)
    association(:actor, factory: :user)

    after(:build) do |invitation, evaluator|
      invitation.email = evaluator.invitee.email
    end

    trait :invited do
      state "invited"
    end
  end
end
