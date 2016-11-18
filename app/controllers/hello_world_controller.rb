class HelloWorldController < ApplicationController
  def index
    @props = { name: 'Ruby on Rails'}
  end
end
