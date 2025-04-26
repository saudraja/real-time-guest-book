class GuestbookEntriesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "guestbook_entries_channel"
  end

  def unsubscribed
    # Cleanup
  end
end
