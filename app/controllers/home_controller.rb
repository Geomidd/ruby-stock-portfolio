class HomeController < ApplicationController
  def index
    @api = StockQuote::Stock.new(api_key: 'pk_b628a6d8440e4428979e4f4568ccf1e0')
    if params[:ticker] == ""
      redirect_to root_path, alert: 'You forgot to enter a symbol!'
    elsif params[:ticker]
      @stock = StockQuote::Stock.quote(params[:ticker])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('ticker_data',
                                                      partial: "home/ticker_data",
                                                      locals: { stock: @stock })
        end
      end
    end
  end
end
