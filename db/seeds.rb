# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

FoodBusiness.create({
    email: 'info@opensaltlake.org',
    name: 'Open Salt Lake',
    username: 'opensaltlake',
    twitter_username: 'opensaltlake',
    facebook_username: 'opensaltlake',
    website_url: 'http://opensaltlake.org',
    password: ENV['DEFAULT_ADMIN_PASSWORD'],
    password_confirmation: ENV['DEFAULT_ADMIN_PASSWORD'],
    is_admin: true
                    })
