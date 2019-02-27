# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# ruby encoding: utf-8
require 'nokogiri'
require 'open-uri'

admin = User.create!(email: "admin@mail.com", password: "test", password_confirmation: "test")
admin.add_role(:admin)
user = User.create!(email: "test@mail.com", password: "test", password_confirmation: "test")
block = user.blocks.create!(title: "Beautiful Words")

doc = Nokogiri::HTML(open('http://www.learnathome.ru/blog/100-beautiful-words'))

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td')[1].content.downcase
  translated = row.search('td')[3].content.downcase
  block.cards.create!(original_text: original, translated_text: translated, user_id: user.id)
end
