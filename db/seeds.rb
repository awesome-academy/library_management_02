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
  email = "vinhtran-#{n+1}@gmail.com"
  User.create!(email: email,
    full_name: name,
    gender: false,
    address: "441 au co",
    phone_number: "0775898786",
    password: "123456",
    password_confirmation: "123456")
end

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

name= ["Sach Tieng Viet", "Van hoc", "Tieu thuyet", "Tinh cam/Lang man",
  "Sach Tieng Anh", "Van hoc", "Kinh te", "Ngan Hang", "Marketing"]
for i in 0..8 do
  Category.create!(name: name[i])
end

50.times do |n|
  name  = Faker::Name.name
  description = Faker::Lorem.sentence(100)
  num_of_pages = n+10
  amount = n+100
  Book.create!(
    name: name,
    description: description,
    num_of_pages: num_of_pages,
    image: Rails.root.join("public/uploads/tmp/vim.png").open,
    amount: amount,
    author_id: 1,
    publisher_id: 1,
    category_id: 1
  )
end

Book.create!(
    name: "a",
    description: "aaaaaa",
    num_of_pages: 100,
    image: Rails.root.join("public/uploads/tmp/vim.png").open,
    amount: 1,
    author_id: 1,
    publisher_id: 1,
    category_id: 1
  )
5.times do |n|
Comment.create!(
  book_id: 1,
  user_id: 1,
  content: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
end
