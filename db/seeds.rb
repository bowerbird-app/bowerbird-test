# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
user = User.find_or_create_by(email: "synmal93@gmail.com") do |u|
  u.password = "asdf1234"
end

['Door', 'Floor', 'Window', 'Building', 'Sky', 'Plant', 'Roof', 'Wood', 'Concrete', 'Glass', 'Aluminium'].each do | t |
  Tag.find_or_create_by(name: t)
end


# create 15 images with glass buildings
if Tag.find_by(name: 'Glass').images.size < 15
  15.times { |index|
    image = Image.create(name: "Glass building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Glass-building', user: user)
    image.image_tags.create(tag: Tag.find_by(name: 'Glass'), probability: Faker::Number.within(range: 0.0..1.0))
  }
end

# create 15 images with concrete buildings
if Tag.find_by(name: 'Concrete').images.size < 15
  15.times { |index|
    image = Image.create(name: "Concrete building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Glass-building', user: user)
    image.image_tags.create(tag: Tag.find_by(name: 'Concrete'), probability: Faker::Number.within(range: 0.0..1.0))
    # Tag.find_by(name: 'Concrete').images.create(name: "Concrete building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Concrete-building', user: user)
  }
end


# tag all images with building in it
Image.includes(:tags).where("lower(name) like ?", "%building%").each do | img |
  img.image_tags.create(tag_id: Tag.find_by(name: 'Building').id, probability: Faker::Number.within(range: 0.0..1.0)) unless img.tags.pluck(:name).include? 'Building'
end

