# frozen_string_literal: true

# Service to calculate the price for a quote.
class CalculateQuote
  attr_reader :quote, :strategy

  def initialize(quote, strategy: CalculateQuote::Simple)
    @quote = quote
    @strategy = strategy.new(quote)
  end

  delegate :call, to: :strategy
end
