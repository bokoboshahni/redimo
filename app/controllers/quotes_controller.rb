# frozen_string_literal: true

# Controller for quotes.
class QuotesController < ApplicationController
  before_action :find_quote, only: %i[show edit update destroy]

  def index; end

  def new
    @quote = Quote.new
  end

  def create
    create_quote = CreateQuote.new(create_quote_params)
    @quote = create_quote.call
    if @quote.persisted?
      redirect_to @quote
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def find_quote
    @quote = Quote.find(params[:id])
  end

  def create_quote_params
    params.require(:quote).permit(:evepraisal_url)
  end
end
