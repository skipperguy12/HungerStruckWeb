class TokensController < ApplicationController
  def create
    @token = Token.new
    @token.email = token_params[:email]
    @token.token = (0...8).map { (65 + rand(26)).chr }.join.downcase

    unless @token.save
      render :json => {error: @token.errors.values.first.to_sentence}
      return
    end

    @random_token = @token.token

    render :json => {token: @random_token}
  end


  private
  def token_params
    params
  end

end
