class UserMailer < ApplicationMailer
  default :from => "no-reply@jungle.com"

  def order_confirmation(order, current_user)
    @order = order
    @email = current_user.email
    mail(to: @email, subject: 'Thank You For Your Jungle Order # #{@order.id}')
  end

end
