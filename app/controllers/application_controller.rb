class ApplicationController < ActionController::Base
  @api = StockQuote::Stock.new(api_key: 'pk_b628a6d8440e4428979e4f4568ccf1e0')
end
