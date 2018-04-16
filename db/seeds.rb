User.destroy_all
Note.destroy_all
Goal.destroy_all
Entry.destroy_all

user = User.create(email: "aob@example.com", password: "password")
entry = Entry.create(user: user, date: Date.today)
3.times do
  Goal.create(description: Faker::Lorem.sentence, entry: entry)
end
Note.create(content: Faker::Lorem.paragraph, entry: entry)
