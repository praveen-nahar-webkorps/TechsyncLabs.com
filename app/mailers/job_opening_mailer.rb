class JobOpeningMailer < ApplicationMailer

  def admin_email(user_data)
    @user_data = user_data

    mail(from: user_data[:email], to: 'praveennahar00@gmail.com', subject: 'New Job Inquiry from Candidate')
  end  
  
  def user_email(user_email)
    mail(from: 'praveennahar00@gmail.com', to: user_email, subject: 'Thank You for Contacting Us!')
  end  
end

  