module Admin
  class SessionsController < ApplicationController
    def create
      admin = AdminUser.find_by(email: params[:email])

      if admin&.authenticate(params[:password])
        render json: { token: ENV['ADMIN_TOKEN'] || 'mysecrettoken' }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
end
