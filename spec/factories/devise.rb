FactoryBot.define do
  factory :user do
    id {'62'}
    name {'Max'}
    email {'testbeta@example.com'}
    password {'password'}
    password_confirmation {'password'}
    confirmation_token {'ZETEST2134'}
  end

  # factory :attendee do
  #   id {'45'}
  #   name {'Jack'}
  #   email {'mailtest@example.com'}
  #   password {'password'}
  #   password_confirmation {'password'}
  #   confirmation_token {'HAYCE2134'}
  # end

  # an example of different user types
  # factory :admin do
  #   id {2}
  #   email {"test@admin.com"}
  #   password {"qwerty"}
  #   admin {true}
  # end
end
