# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :integer
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  gender_id              :bigint
#  user_type_id           :bigint
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  active                 :boolean          default(TRUE)
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_validation
    users(:john).user_type = nil
    assert_false(users(:john).valid?)

    users(:kart).email = nil
    assert_false(users(:kart).valid?)
  end

  def test_associations
    john = users(:john)
    assert_equal(user_types(:admin), john.user_type)
    assert_equal(genders(:male), john.gender)
    assert_equal(addresses(:john), john.address)
    passwords = Password.all.order(:id)
    john.passwords.order(:id).each_with_index do |address, index|
      assert_equal(passwords[index], address)
    end
  end

  def test_scopes
    assert_equal([users(:john), users(:kart)], User.active)
    assert_equal([users(:jack)], User.in_active)
  end

  def test_delegates
    assert_equal('Male', users(:john).gender_name)
    assert_equal('Admin', users(:john).user_type_name)
    assert_equal('Nathalie Radial', users(:john).address_street)
    assert_equal(5528, users(:john).address_number)
    assert_nil(users(:john).address_additional_details)
    assert_equal('Mckenzie Field', users(:john).address_house_name)
    assert_equal('Chennai', users(:john).address_city_name)
    assert_equal('Tamil Nadu', users(:john).address_state_name)
    assert_equal('29729', users(:john).address_zipcode)
  end

  def test_alias
    assert_equal('Kart Rosita', users(:kart).name)
  end

  def test_email
    assert_mails(1) do
      users(:kart).send_mail
    end
  end

  def test_full_name
    assert_equal('Kart Rosita', users(:kart).full_name)
  end

  def test_status
    assert_equal('Active', users(:kart).status)
    assert_equal('In Active', users(:jack).status)
  end

  def test_admin?
    assert_true(users(:john).admin?)
    assert_false(users(:kart).admin?)
  end

  def test_member_since
    assert_equal(Time.now.strftime("%b, %Y"),users(:john).member_since)
  end

  def test_create
    assert_difference("User.count", 1) do
      User.create(user_params)
    end
  end

  def test_update
    user = User.create(user_params)
    assert_equal('Test User', user.first_name)
    assert_difference("User.count", 0) do
      user.update_attribute(:first_name, 'Tester')
    end
    assert_equal('Tester', user.reload.first_name)
  end

  def test_delete
    User.create(user_params)
    assert_difference("User.count", -1) do
      User.last.destroy
    end
  end

  def test_attachment
    john = users(:john)
    image = File.new(File.join(Rails.root, "/test/files", "image.png"))
    john.update_attribute(:avatar, image)
    assert_not_nil(john.reload.avatar_updated_at)
    assert_equal('image.png', john.avatar_file_name)
    assert_equal('image/png', john.avatar_content_type)
    assert_equal(16113, john.avatar_file_size)
  end

  private

  def user_params
    {
      first_name: 'Test User',
      user_type_id: user_types(:user).id,
      email: 'test@admin.com',
      password: 'password',
      password_confirmation: 'password',
      gender_id: genders(:male).id,
    }
  end
end
