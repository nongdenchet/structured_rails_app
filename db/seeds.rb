require 'faker'

# User
avatar = 'https://yt3.ggpht.com/-OXV3r-moC7M/AAAAAAAAAAI/AAAAAAAAAAA/hiDmd5qlL58/s88-c-k-no-mo-rj-c0xffffff/photo.jpg'
user = User.create(
  email: 'rain@apidez.com',
  password: 123123123,
  name: 'Vũ Huy Quân',
  remote_image_url: avatar
)

# Recipes
24.times do |index|
  time = index % 10 + 1
  Recipe.create(
    user: user,
    title: Faker::Lorem.words(3).join(' '),
    description: Faker::Lorem.paragraph(1),
    remote_image_url: 'http://www.menshealth.com/sites/menshealth.com/files/coffee-mug.jpg',
    prepare_time: time,
    cook_time: time + 1,
    ready_time: time + 2)
end
