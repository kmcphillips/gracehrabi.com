# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Deleting all Blocks"
Block.destroy_all
puts "Creating blocks"
Block.create! :body => "", :label => "about", :path => "/about"
Block.create! :body => "", :label => "contact", :path => "/contact"

if Rails.env.development?
  puts "Deleting all Users"
  User.destroy_all
  puts "Creating test/test development User"
  User.create! :username => "test", :password_hash => User.encrypt("test")
end

