Poll.create([
              { question: "What is your favorite food?", options_attributes: [{ content: "Pizza" }, { content: "Burger" }, { content: "Pasta" }] },
              { question: "Which season do you prefer?", options_attributes: [{ content: "Spring" }, { content: "Summer" }, { content: "Fall" }, { content: "Winter" }] },
              { question: "Do you like reading books?", options_attributes: [{ content: "Yes" }, { content: "No" }] }
            ])
Admin.create!(
  username: "admin",
  password: ENV['ADMIN_PASSWORD'] || "default_password",
  password_confirmation: ENV['ADMIN_PASSWORD'] || "default_password"
)
