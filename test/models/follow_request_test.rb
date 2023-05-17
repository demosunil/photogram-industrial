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
require "test_helper"

class FollowRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
