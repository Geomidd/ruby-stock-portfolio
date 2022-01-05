class HomeController < ApplicationController
  def index
    if params[:ticker] == ""
      redirect_to root_path, alert: 'You forgot to enter a symbol!'
    elsif params[:ticker]
      puts params[:ticker]
      begin
        @stock = StockQuote::Stock.quote(params[:ticker])
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.update('ticker_data',
                                                        partial: "home/ticker_data",
                                                        locals: { stock: @stock })
          end
        end
      rescue
        redirect_to root_path, alert: "Error occurred trying to get data for #{params[:ticker]}"
      end
    end
  end
end
