class ContactMailer < ApplicationMailer
    def admin_email(object)
        @object = object
    
        mail(from: @object[:email], to: 'praveen@webkorps.com', subject: 'New object Form Submission') do |format|
          format.text do
            body = "Name: #{@object.name}\n"
            body += "Email: #{@object.email}\n"
            body += "Phone Number 1: #{@object.phone1}\n"
            body += "Phone Number 2: #{@object[:phone2]}\n"
            body += "Location: #{@object.location}\n"
            body += "Message: #{@object.message}\n"
          end
        end
      end
    
      def user_email(user_email)
        mail(from: 'praveen@webkorps.com', to: user_email, subject: 'Thank you for contacting us!') do |format|
          format.text { render plain: 'Thank you for contacting us! We have received your message and will get back to you shortly.' }
        end
      end
end
