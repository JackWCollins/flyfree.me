Fabricator(:user) do
	email { Faker::Internet.email }
	password 'password'
	username { Faker::Name.first_name }
end

Fabricator(:admin, from: :user) do
	admin true
end