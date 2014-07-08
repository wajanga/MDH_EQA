namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    #make_facility_types
    #make_facility
    #make_result
    #make_eqa
    #make_sent_samples
  end
end

def make_users
  admin = User.create!(username:     "awkondoro",
                       email:    "awkondoro@vastech.co.tz",
                       password: "awkondoro",
                       password_confirmation: "awkondoro")
  User.create!(username:     "sample123",
                 email:    "sample123@vastech.co.tz",
                 password: "sample123",
                 password_confirmation: "sample123")
  ##
  #99.times do |n|
    #name  = Faker::Name.name
    #email = "example-#{n+1}@railstutorial.org"
    
    #password  = "password"
    #User.create!(username:     name,
    #            email:    email,
    #            password: password,
    #            password_confirmation: password)
  #end
end

def make_regions
  Region.create!(name: "Dar-es-Salaam")
end

def make_districts
  region = Region.first
  region.districts.create!(name: "Kinondoni")
end

def make_facility_types
  FacilityType.create!(name: "LAB")
  FacilityType.create!(name: "PMTCT")
  FacilityType.create!(name: "PICT")
  FacilityType.create!(name: "VCT")
  FacilityType.create!(name: "TB-HIV")
end

def make_facility
  region = Region.create!(name: "Dar-es-Salaam")
  district = region.districts.create!(name: "Kinondoni")
  #facility_type = FacilityType.create!(name: "Lab")
  Facility.create!(name: "Mwananyamala Regional Hospital", facility_type_id: 1, district_id: district.id,
    facility_no: 123)
  Facility.create!(name: "Sinza Hospital", facility_type_id: 2, district_id: district.id,
    facility_no: 321)
end

def make_result
  Result.create!(facility_id: 1, eqa_test_id: 1, sample_receive_date: "2014-05-20", 
    done_by: "Aron", assay1_no: "123", assay2_no: "123", 
    approved_by: "Abdallah", test_done_date: "2014-05-20", assay1_expiry_date: "2014-05-20", 
    assay2_expiry_date: "2014-05-20", result_received_date: "2014-05-20")
end

def make_eqa
  EqaTest.create!(eqa_number: "1", start_date: "2014-01-01", end_date: "2014-12-30")
end

def make_sent_samples
  SentSample.create!(specimen_id: "A1", d_expected_result: "REACTIVE", u_expected_result: "REACTIVE", 
    f_expected_result: "POSITIVE", eqa_test_id: 1, facility_id: 1)
  SentSample.create!(specimen_id: "A2", d_expected_result: "NON-REACTIVE", u_expected_result: "N/A", 
    f_expected_result: "NEGATIVE", eqa_test_id: 1, facility_id: 1)
  SentSample.create!(specimen_id: "A3", d_expected_result: "NON-REACTIVE", u_expected_result: "N/A", 
    f_expected_result: "NEGATIVE", eqa_test_id: 1, facility_id: 1)
end

##
#def make_microposts
  #users = User.all(limit: 6)
  #50.times do
  # content = Faker::Lorem.sentence(5)
  # users.each { |user| user.microposts.create!(content: content) }
  #end
#end

#def make_relationships
  #users = User.all
  #user  = users.first
  #followed_users = users[2..50]
  #followers      = users[3..40]
  #followed_users.each { |followed| user.follow!(followed) }
  #followers.each      { |follower| follower.follow!(user) }
#end