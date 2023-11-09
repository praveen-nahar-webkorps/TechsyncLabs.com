class JobOpeningsController < ApplicationController
  require 'google/apis/sheets_v4'
  require 'googleauth'
  
  def create
    @jobOpening = JobOpening.new(jobOpening_params)

    if @jobOpening.save
      begin
        JobOpeningMailer.admin_email(@jobOpening).deliver_now         # Send email to admin
        JobOpeningMailer.user_email(params[:email]).deliver_now    # Send email to user

        write_to_google_sheets(@jobOpening)

        render json:{data: @jobOpening, message: "Email sent successfully" }, status: :ok
      rescue StandardError => e
        render json: { message: "Error sending email to admin: #{e.message}" }, status: :internal_server_error
      end
    else
      render json:{errors: @jobOpening.errors.full_messages },status: :unprocessable_entity
    end
  end

  private

  def jobOpening_params
    params.permit(:first_name, :last_name, :email, :phone, :address, :education, :skills, :total_exp, :personal_quality, :text_info)
  end
  
  def write_to_google_sheets(job_opening)
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = 'Google Sheets API'
    service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(Rails.root.join('config', 'users-contact-data-6266e88a0ec0.json')),
      scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
    )
  
    spreadsheet_id = '128ZbZG0Rbenmj8Pi-WdHfV13pxPm_Uvuyr1L0OJpIsE'
    sheet_name = 'JobOpeningsSheet'  
    range = "#{sheet_name}!A:A"  
  
    values = [[job_opening.first_name, job_opening.last_name, job_opening.email, job_opening.phone, job_opening.address, job_opening.education, job_opening.skills, job_opening.total_exp, job_opening.personal_quality, job_opening.text_info]]
  
    request_body = Google::Apis::SheetsV4::ValueRange.new(values: values)
    result = service.append_spreadsheet_value(spreadsheet_id, range, request_body, value_input_option: 'RAW', insert_data_option: 'INSERT_ROWS')
  
  end
  
end
