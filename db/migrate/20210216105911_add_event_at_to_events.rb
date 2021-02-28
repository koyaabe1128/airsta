class AddEventAtToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_at, :datetime
  end
end
