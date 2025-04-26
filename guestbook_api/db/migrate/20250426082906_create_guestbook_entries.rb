class CreateGuestbookEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :guestbook_entries do |t|
      t.string :name
      t.text :message
      t.boolean :is_spam, default: false

      t.timestamps
    end
  end
end
