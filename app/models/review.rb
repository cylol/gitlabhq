class Review < ActiveRecord::Base
  belongs_to :merge_request
end
