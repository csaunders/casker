class Import < ActiveRecord::Base
  serialize :processed_data, Hash

  def mark_as_complete
    update_attributes(completed_at: Time.now)
  end
end
