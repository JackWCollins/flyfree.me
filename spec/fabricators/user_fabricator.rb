Fabricator(:user) do
	email { Faker::Internet.email }
	password 'password'
	full_name { Faker::Name.name }
	username { Faker::Name.first_name }
end

Fabricator(:admin, from: :user) do
	admin true
end