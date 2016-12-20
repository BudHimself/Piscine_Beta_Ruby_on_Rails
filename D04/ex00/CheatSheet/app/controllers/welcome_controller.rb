#descripton de ouf

class WelcomeController < ApplicationController

  def editor
    @title = "editor"
  end

  def convention
    @title = "convention"
  end

  def ruby
    @title = "ruby"
  end

  def console
    @title = "console"
  end

  def numbers
    @title = "numbers"
  end

  def strings
    @title = "strings"
  end

  def arrays
    @title = "arrays"
  end

  def hashes
    @title = "hashes"
  end

  def rails_app
    @title = "rails_app"
  end

  def rails_commands
    @title = "rails_commands"
  end

  def embedded_ruby
    @title = "embedded_ruby"
  end
end
