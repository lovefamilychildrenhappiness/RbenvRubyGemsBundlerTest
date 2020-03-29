# remember to make this executable: chmod +x bundle.sh
echo "This assumes you have rbenv 2.6.0 active: $(rbenv versions)"

if [ -d "$HOME/projects/rails-app" ]; then
    echo "directory $HOME/projects/rails-app already exists"
    exit 1
fi

mkdir "$HOME/projects/rails-app" && cd $HOME/projects/rails-app

# should install to gem environment | grep INSTALLATION
# we use 1.17.2 because we will install Rails 4.2
gem install bundler -v 1.17.2 

bundle init
echo "gem 'rails', '~> 4.2.8.rc1'" >> Gemfile
bundle install --path=vendor/bundle # this installs gem in project, not in RubyGems INSTALLATION DIRECTORY
bundle exec rails new . -f --skip-bundle
rm Gemfile.lock # bundler bug?
bundle install --path=vendor/bundle # now install all the gems in Gemfile created by rails new
bundle binstub rails # need to install a binstub so I can use 'rails s' instead of 'bundle exec rails s'
rails s


