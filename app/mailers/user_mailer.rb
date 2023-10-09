class UserMailer < ApplicationMailer
    def admin_email(object)
      @object = object
  
      mail(from: @object[:email], to: 'praveen@webkorps.com', subject: 'New object Form Submission') do |format|
        format.text do
          body = "Name: #{@object.first_name} #{@object.last_name}\n"
          body += "Email: #{@object.email}\n"
          body += "Phone Number: #{@object.phone}\n"
          body += "Address: #{@object[:address]}\n"
          body += "Job Number: #{@object.job_no}\n"
          body += "Additional Information: #{@object.add_info}\n"
          body += "Education: #{@object.education}\n"
          body += "Skills: #{@object.skills}\n"
          body += "Total Experience: #{@object.total_exp}\n"
          body += "Personal Quality: #{@object.personal_quality}\n"
          body += "File: #{@object.file}\n"
          body += "Desired work: #{@object.desired_work}\n"
        end
      end
    end
  
    def user_email(user_email)
      mail(from: 'praveen@webkorps.com', to: user_email, subject: 'Thank you for contacting us!') do |format|
        format.text { render plain: 'Thank you for contacting us! We have received your message and will get back to you shortly.' }
      end
    end
end
  