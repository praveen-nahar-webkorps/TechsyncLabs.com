class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      begin
        ContactMailer.admin_email(@contact).deliver_now         # Send email to admin
        ContactMailer.user_email(params[:email]).deliver_now    # Send email to user
        render json:{data: @contact, message: "Email sent successfully" }, status: :ok
      rescue StandardError => e
        render json: { message: "Error sending email to admin: #{e.message}" }, status: :internal_server_error
      end
      
    else
        render json:{errors: @contact.errors.full_messages },status: :unprocessable_entity
    end
  end
  
  private
    
  def contact_params
    params.permit(:first_name, :last_name, :email, :phone, :address)
  end
        
end
