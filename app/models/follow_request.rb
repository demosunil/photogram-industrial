# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  recipient_id :bigint           not null
#  sender_id    :bigint           not null
#  status       :string           default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class FollowRequest < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
end
