module Admin
  class GuestbookEntriesController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate_admin!

    def index
      entries = GuestbookEntry.order(created_at: :desc)
      render json: entries
    end

    def mark_spam
      entry = GuestbookEntry.find(params[:id])
      entry.update(is_spam: true)
      head :no_content
    end

    def destroy
      entry = GuestbookEntry.find(params[:id])
      entry.destroy
      head :no_content
    end

    private

    def authenticate_admin!
      authenticate_or_request_with_http_token do |token, _options|
        ActiveSupport::SecurityUtils.secure_compare(token, ENV["ADMIN_TOKEN"] || "mysecrettoken")
      end
    end
  end
end
