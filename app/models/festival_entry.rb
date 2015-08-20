class FestivalEntry < ActiveRecord::Base
  belongs_to :festival
  belongs_to :beer

  validates :festival_identifier, presence: true
  serialize :metadata, Hash

  def [](meta_key)
    metadata[meta_key]
  end

  def []=(meta_key, meta_value)
    metadata[meta_key] = meta_value
  end
end
