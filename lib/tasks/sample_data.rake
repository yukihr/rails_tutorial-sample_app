namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_comments
  end

  def make_users
    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end

  def make_relationships
    users = User.all
    user  = users.first
    followed_users = users[2..50]
    followers      = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each      { |follower| follower.follow!(user) }
  end

  def make_comments
    users = User.all
    user  = users.first
    comment_users = users.select {|u| u.id % 10 == 0 }
    commented_microposts = user.microposts[2..10]
    commented_microposts.each do |m|
      puts m.to_s
      comment_users.each do |u|
        puts u.to_s
        content = Faker::Lorem.sentence(5)
        u.comments.create!(content: content, micropost_id: m.id)
      end
    end
  end
end
