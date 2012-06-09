namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    admin = User.create!( 
                  :username                => "Liquid",
                  :firstname               => "Jacob",
                  :lastname                => "Sikorski",
                  :email                   => "jacob.sikorski@gmail.com",
                  :password                => "foobar",
                  :password_confirmation   => "foobar")
    
    admin.toggle!(:admin)

    99.times do |n|
      username  = "user-#{n+1}"
      firstname = Faker::Name.first_name
      lastname  = Faker::Name.last_name
      email     = "user-#{n+1}@example.org"
      password  = "foobar"
      User.create!( 
                  :username              => username,
                  :firstname             => firstname,
                  :lastname              => lastname,
                  :email                 => email,
                  :password              => password,
                  :password_confirmation => password)
    end

    users = User.all(:limit => 6)
    50.times do
      content = Faker::Lorem.sentence(10)
      users.each { |user| user.articles.create!(:content => content) }
    end
  end
end