User.create!(email: "vinhtran09121997@gmail.com",
  full_name: "Tran Ngoc Vinh",
  gender: true,
  address: "441 au co",
  phone_number: "0775898786",
  password: "123456",
  password_confirmation: "123456",
  role: 1)

10.times do |n|
  name  = Faker::Name.name
  Author.create!(
    name: name,
    description: "Tran Ngoc Vim ...............................")
end

10.times do |n|
  name  = Faker::Name.name
  Publisher.create!(
    name: name,
    description: "Ngoen Ngoen ...............................")
end

Category.create!(
  name: "romantic"
)

50.times do |n|
  name  = Faker::Name.name
  Book.create!(
    name: name,
    description: "Ngoen Ngoen ..............................................
      ......................................................................
      ......................................................................
      .................................................................Ngoen",
    num_of_pages: 10,
    image: Rails.root.join("public/uploads/tmp/vim.png").open,
    amount: 10,
    author_id: 1,
    publisher_id: 1,
    category_id: 1
  )
end
