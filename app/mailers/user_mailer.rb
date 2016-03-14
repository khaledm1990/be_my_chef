

class UserMailer < ActionMailer::Base
    default :from => "Confirmation_email@be_my_chef.com"

   def registration_confirmation(user)
      @user = user
      mail(:to => "#{user.name} <#{user.email}>", :subject => "Please Confirm your account")
   end

end
