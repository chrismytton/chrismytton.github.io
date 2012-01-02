
desc 'Build blog css and js'
task :build => ['build:css', 'build:js']

namespace :build do
  task :css do
    system('stylus -c css/hecticjeff.styl')
  end

  task :js do
    system('cat js/vendor/jquery.color.min.js js/vendor/jquery.konami.js js/main.js | uglifyjs > js/hecticjeff.js')
  end
end
