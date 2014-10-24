# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

source = File.join(Rails.root, 'db/data/casks.yml')
casks = YAML::load_file(source)
casks.each do |cask|
  Cask.create(cask)
end
