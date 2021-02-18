# frozen_string_literal: true

# Controller for homepage.
class HomeController < ApplicationController
  def index
    @quote = Quote.new
  end
end
