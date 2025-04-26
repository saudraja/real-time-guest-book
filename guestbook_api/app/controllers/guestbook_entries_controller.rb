class GuestbookEntriesController < ApplicationController
  def index
    entries = GuestbookEntry.recent_non_spam
    render json: entries
  end

  def create
    entry = GuestbookEntry.new(guestbook_entry_params)
    if entry.save
      ActionCable.server.broadcast "guestbook_entries_channel", entry
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:name, :message)
  end
end
