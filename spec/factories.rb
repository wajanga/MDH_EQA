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

  factory :result do
    facility_id 1
    sequence(:eqa_test_id)  { |n| n }
    sample_receive_date "2014-01-01"
    done_by "Abdallah"
    assay1_no "123"
    assay2_no "123"
    approved_by "Aron"
    test_done_date "2014-01-01"
    assay1_expiry_date "2014-01-01"
    assay2_expiry_date "2014-01-01"
    result_dispatched_date "2014-01-01"
    result_received_date "2014-01-01"
  end
end