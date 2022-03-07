# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# ['Door', 'Floor', 'Window', 'Building', 'Sky', 'Plant', 'Roof', 'Wood', 'Concrete', 'Glass', 'Aluminium'].each do | t |
#   Tag.find_or_create_by(name: t)
# end


# # create 15 images with glass buildings
# if Tag.find_by(name: 'Glass').images.size < 15 
#   15.times { |index| 
#     Tag.find_by(name: 'Glass').images.create(name: "Glass building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Glass-building')
#   }
# end

# # create 15 images with concrete buildings
# if Tag.find_by(name: 'Concrete').images.size < 15 
#   15.times { |index| 
#     Tag.find_by(name: 'Concrete').images.create(name: "Concrete building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Concrete-building')
#   }  
# end


# # tag all images with building in it
# Image.includes(:tags).where("lower(name) like ?", "%building%").each do | img |
#   img.image_tags.create(tag_id: Tag.find_by(name: 'Building').id) unless img.tags.pluck(:name).include? 'Building'
# end

# now that we have the tagging system ready, we can just feed in the images and tags will be automatically created
# first we create a test account
user = User.create!(email: 'user@test.com', password: 'password')

15.times do |index|
  # # create 15 images with glass buildings
  user.images.create(name: "Glass building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Glass-building')
  # # create 15 images with concrete buildings
  user.images.create(name: "Concrete building #{index + 1}", remote_file_url: 'https://loremflickr.com/300/300/Concrete-building')
end
