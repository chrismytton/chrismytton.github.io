
desc 'Watch js and css files for changes and rebuild'
task :watch do
  system("command -v kicker && kicker -e 'rake build' css/*.styl 'js/main.js' || echo 'You need to \"gem install kicker\" to watch files'")
end

desc 'Build blog css and js'
task :build => ['build:css', 'build:js']

namespace :build do
  desc 'Build blog css'
  task :css do
    system('stylus --compress css/hecticjeff.styl')
  end

  desc 'Build blog javascripts'
  task :js do
    system("cat #{javascripts.join(' ')} | uglifyjs > js/hecticjeff.js")
  end

  def javascripts
    %w{js/vendor/jquery.color.min.js js/vendor/jquery.konami.js js/vendor/jquery.timeago.js js/main.js}
  end
end

task :default => :build
