super_admin_role = Role.create!(role: "superadmin")
super_admin_user = User.create!(first_name: "John", last_name: "Wick", email: "john.wick@gmail.com", phone_number: "9876543211", password: "12345678", password_confirmation: "12345678")
customer_role = Role.find_by(role: "customer")
super_admin_user.roles << super_admin_role
super_admin_user.roles.destroy(customer_role)
