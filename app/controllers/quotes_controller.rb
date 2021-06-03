# frozen_string_literal: true

# Controller for quotes.
class QuotesController < ApplicationController
  layout 'landing'

  def create
    @quote = CreateQuote.new(params[:appraisal_url]).call
    if @quote
      redirect_to quote_path(@quote.id)
    else
      render :error
    end
  end

  def show
    @quote = Quote.find(params[:id])
  end

  private

  helper_method :quote
  attr_reader :quote
end
