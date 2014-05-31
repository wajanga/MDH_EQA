namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_facility
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
  FacilityType.create!(name: "Lab")
  FacilityType.create!(name: "PMTCT")
end

def make_facility
  region = Region.create!(name: "Dar-es-Salaam")
  district = region.districts.create!(name: "Kinondoni")
  facility_type = FacilityType.create!(name: "Lab")
  Facility.create!(name: "Mwananyamala Regional Hospital", facility_type_id: facility_type.id, district_id: district.id)
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