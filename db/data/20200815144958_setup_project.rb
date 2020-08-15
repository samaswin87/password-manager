class SetupProject < ActiveRecord::Migration[5.2]
  def up

    Gender.create!([
        { name: 'Male', alias: 'male' },
        { name: 'Female', alias: 'female' }
      ])

    UserType.create!([
        { name: 'Administrator', alias: 'administrator' },
        { name: 'User', alias: 'user' },
      ])

    # data

    State.create!([
        {name: 'Andra Pradesh'},
        {name: 'Arunachal Pradesh'},
        {name: 'Assam'},
        {name: 'Bihar'},
        {name: 'Chhattisgarh'},
        {name: 'Goa'},
        {name: 'Gujarat'},
        {name: 'Haryana'},
        {name: 'Himachal Pradesh'},
        {name: 'Jammu and Kashmir'},
        {name: 'Jharkhand'},
        {name: 'Karnataka'},
        {name: 'Kerala'},
        {name: 'Madya Pradesh'},
        {name: 'Maharashtra'},
        {name: 'Manipur'},
        {name: 'Meghalaya'},
        {name: 'Mizoram'},
        {name: 'Nagaland'},
        {name: 'Orissa'},
        {name: 'Punjab'},
        {name: 'Rajasthan'},
        {name: 'Sikkim'},
        {name: 'Tamil Nadu'},
        {name: 'Telagana'},
        {name: 'Tripura'},
        {name: 'Uttaranchal'},
        {name: 'Uttar Pradesh'},
        {name: 'West Bengal'},
        {name: 'Other'}
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
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
