# Create a main sample user.
User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar"
)

User.create!(name:  "James",
    email: "james@anandavibetribe.com",
    password:              "123456",
    password_confirmation: "123456",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now)
end

# Generate micoroposts for a sub-set of users.

users = User.order(:created_at).take(6)
50.times do
    content = Faker::hipster.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) }
end