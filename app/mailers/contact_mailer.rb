class ContactMailer < ApplicationMailer

  def admin_email(user_data)  
    @user_data = user_data

    mail(from: user_data.email, to: 'praveennahar00@gmail.com', subject: 'New Applicant Interested in Contacting')
  end
    
  def user_email(user_email)
    mail(from: 'blueflame@admin.com', to: user_email, subject: 'Thank You for Contacting Us!')
  end
end
