require 'test_helper'

class PasswordDecoratorTest < Draper::TestCase
  def test_status_button
    password_decorator = PasswordDecorator.decorate(passwords(:john_facebook))
    button_html = '<button class="btn btn-success pull-right" id="password_status"><i class="fa fa-unlock"></i></button>'

    assert_equal(button_html, password_decorator.status_button)

    password_decorator = PasswordDecorator.decorate(passwords(:john_insta))
    button_html = '<button class="btn btn-danger pull-right" id="password_status"><i class="fa fa-lock"></i></button>'

    assert_equal(button_html, password_decorator.status_button)
  end

  def test_edit_icon
    password_decorator = PasswordDecorator.decorate(passwords(:john_facebook))
    edit_html = '<a class="btn btn-success" href="/passwords/1/edit"><i class="fa fa-edit"></i></a>'

    assert_equal(edit_html, password_decorator.edit_icon)
  end

  def test_delete_attachment
    password_decorator = PasswordDecorator.decorate(passwords(:john_facebook))
    attachment_html = '<a data-confirm-swal="Are you sure?" rel="nofollow" data-method="delete" href="/passwords/1/attachment?attachment_id=1"><i class="fa fa-minus-circle fa-pull-right"></i></a>'
    assert_equal(attachment_html, password_decorator.delete_attachment(1))
  end
end
