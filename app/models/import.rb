class Import < ActiveRecord::Base
  serialize :processed_data, Hash
end
