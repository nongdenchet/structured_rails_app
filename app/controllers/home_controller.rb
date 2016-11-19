class HomeController < ApplicationController
  def index
    @props = { name: 'Ruby on Rails'}
  end
end
