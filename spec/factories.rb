FactoryGirl.define do
  factory :user do
    username     "awkondoro"
    email    "awkondoro@vastech.co.tz"
    password "awkondoro"
    password_confirmation "awkondoro"
  end

  factory :facility do
    name     "Mwananyamala Regional Hospital"
    facility_type_id    1
    district_id 1
    facility_no 123
  end

  factory :eqa_test do
    eqa_number     "1"
    start_date    "2014-01-01"
    end_date "2014-12-30"
  end
end