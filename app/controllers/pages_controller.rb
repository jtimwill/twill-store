class PagesController < ApplicationController
  def front
  end

  def faq
    flash.now[:warning] = "Warning: this is page contains information about the
                          original version of this project. See the README file
                          for information about the current version."
  end
end
