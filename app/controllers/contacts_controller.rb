class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      begin
        ContactMailer.admin_email(@contact).deliver_now         # Send email to admin
        ContactMailer.user_email(params[:email]).deliver_now    # Send email to user

        write_to_google_sheets(@contact)
        
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


  require 'google/apis/sheets_v4'
  require 'googleauth'

  def write_to_google_sheets(contact)
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = 'Your Application Name'
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join('config', 'users-contact-data-6266e88a0ec0.json')),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )
  
    spreadsheet_id = '128ZbZG0Rbenmj8Pi-WdHfV13pxPm_Uvuyr1L0OJpIsE'
  
    # Get the last row number with data
    range = 'A:A'  # Assuming column A is always populated
    result = service.get_spreadsheet_values(spreadsheet_id, range)
    last_row = result.values&.size.to_i + 1
  
    # Define the range for the new entry
    range = "A#{last_row}:E#{last_row}"
  
    # Prepare the values
    values = [[contact.first_name, contact.last_name, contact.email, contact.phone, contact.address]]
  
    # Write contact data to the new row
    request_body = Google::Apis::SheetsV4::ValueRange.new(values: values)
    result = service.update_spreadsheet_value(spreadsheet_id, range, request_body, value_input_option: 'RAW')
  
    # puts "Updated #{result.updated_cells} cells."
  end
  
        
end
