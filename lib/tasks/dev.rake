task sample_data: :environment do
  puts "Creating sample data"
  starting = Time.now

  if Rails.env.development?
    FollowRequest.destroy_all
    Like.destroy_all # Delete all likes before deleting users and photos
    Photo.destroy_all
    User.destroy_all # Delete all users
  end

  users = []
  
  12.times do
    name = Faker::Name.first_name.downcase
    u = User.create(
      email: "#{name}@example.com",
      username: name,
      password: "password",
      private: [true, false].sample
    )
    users << u
  end

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end 
      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end 
  end 

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )
      user.followers.each do |follower|
        if rand < 0.5
          # Skip creating a new Like record if the photo already has Likes
        #next if photo.likes.exists?(fan_id: follower.id)

          photo.likes.create(fan: follower)
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end

  ending = Time.now
  puts "It took #{(ending - starting).to_i} seconds to create sample data."
  puts "There are now #{User.count} users."
  puts "There are now #{FollowRequest.count} follow requests."
  puts "There are now #{Photo.count} photos."
  puts "There are now #{Like.count} likes."
  puts "There are now #{Comment.count} comments."
end
