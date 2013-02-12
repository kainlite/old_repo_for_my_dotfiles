require 'rake'
require 'erb'

desc 'Update all the updatable things'
task :update do
  puts %x{git pull origin master}
  puts %x{git submodule foreach git pull origin master}

  repositories = %w('.rbenv', '.rbenv/plugins/ruby-build', '.oh-my-zsh', '.dotfiles')

  repositories.each do |repository|
    puts %x{cd $HOME/#{repository}; git pull; cd -} if File.directory?(File.join(ENV['HOME'], repository, '.git'))
  end

  puts %x{curl -Sso ~/.dotfiles/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim}
end
