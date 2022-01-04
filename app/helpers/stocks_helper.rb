module StocksHelper
  def get_stock_data(stock)
    @stock_data = nil
    @error = nil
    if stock.ticker == ""
      @error = "No ticker provided"
    elsif stock.ticker
      begin
        @stock_data = StockQuote::Stock.quote(stock.ticker)
      rescue
        @error = "Could not retrieve data for #{stock.ticker}"
      end
    end
    return {
      'error' => @error,
      'data' => @stock_data,
    }
  end
end
