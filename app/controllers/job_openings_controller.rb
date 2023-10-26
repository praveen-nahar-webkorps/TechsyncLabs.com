class JobOpeningsController < ApplicationController
  def create
    @jobOpening = JobOpening.new(jobOpening_params)

    if @jobOpening.save
      begin
        JobOpeningMailer.admin_email(@jobOpening).deliver_now         # Send email to admin
        JobOpeningMailer.user_email(params[:email]).deliver_now    # Send email to user
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
  
end
