# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    user = User.new(user_params)
    if user.save
      render json: user.as_json(
        auth_token: user.authentication_token,
        email: user.email,
        name: user.name,
        mobile: user.mobile,
        organisation: user.organisation,
        job_title: user.job_title
      ), status: 201
    else
      warden.custom_failure!
      render json: user.errors, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :mobile, :name,
                  :organisation, :job_title)
  end
end
