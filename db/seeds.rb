# defaults

Gender.create!([
    { name: 'Male', alias: 'male' },
    { name: 'Female', alias: 'female' }
  ])

UserType.create!([
    { name: 'Administrator', alias: 'administrator' },
  ])

# data

State.create!([
    { name: 'Tamil Nadu', initials: 'TN' },
    { name: 'Kerala', initials: 'KL' }
  ])

City.create!([
    { name: 'Chennai', state_id: 1 },
    { name: 'Kollam', state_id: 2 }
  ])

user = User.new(first_name: 'Administrator',
                last_name: '',
                phone: '',
                email: 'admin@admin.com',
                password: 'password',
                password_confirmation: 'password',
                gender_id: 1,
                user_type_id: 1)

user.save(validate: false)
