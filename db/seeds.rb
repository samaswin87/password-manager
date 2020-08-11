# defaults

Gender.create!([
    { name: 'Masculino', alias: 'male' },
    { name: 'Feminino', alias: 'female' }
  ])

UserType.create!([
    { name: 'Administrador', alias: 'administrator' },
  ])

# data

State.create!([
    { name: 'São Paulo', initials: 'SP' },
    { name: 'Minas Gerais', initials: 'MG' }
  ])

City.create!([
    { name: 'Mogi Mirim', state_id: 1 },
    { name: 'Poços de Caldas', state_id: 2 }
  ])

user = User.new(first_name: 'Administrador',
                last_name: '',
                phone: '',
                email: 'admin@admin.com',
                password: 'qwerty',
                password_confirmation: 'qwerty',
                gender_id: 1,
                user_type_id: 1)

user.save(validate: false)
