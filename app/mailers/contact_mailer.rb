class ContactMailer < ApplicationMailer

  def admin_email(user_data)  
    mail(from: user_data.email, to: 'praveennahar00@gmail.com', subject: 'New user_data Form Submission') do |format|
      format.text do
        body = "Name: #{user_data.first_name} #{user_data.last_name}\n"
        body += "Email: #{user_data.email}\n"
        body += "Phone Number: #{user_data.phone}\n"
        body += "Address: #{user_data.address}\n"
      end
    end
  end
    
  def user_email(user_email)
    mail(from: 'praveennahar00@gmail.com', to: user_email, subject: 'Thank you for contacting us!') do |format|
      format.text { render plain: 'Thank you for contacting us! We have received your message and will get back to you shortly.' }
    end
  end
end
