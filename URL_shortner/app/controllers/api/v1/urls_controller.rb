class Api::V1::UrlsController < ApplicationController

  def create
    unless url_params.blank?

      @full_url = Url.new(url_params)

      @initial_shortened = @full_url[:long_url].slice(0..3)
      @final_shortened = @full_url[:long_url].slice(-3..-1)
      @url_shortened = @initial_shortened + @final_shortened

      if @full_url.save
       # @shortened = Shortener::ShortenedUrl.generate(url_params[:long_url])
       render :json => {message:"Successfully saved complete URL",data: @full_url,:status => 201}
     else
      render :json => {message:"Invalid entry",data: @full_url.errors,:status => 422}
    end
  else
    render :json => {message:"Fill the empty fields",:status => 422}
  end
end

def show
  @url = Url.find(params[:id])
  redirect_to @url.long_url
end

def generate_short_url
  @url = Url.find(params[:id])
  #Assuming this pattern "www.google.com"
  @url_shortened= @url.slice!(0..3) + @url.slice!(-3..-1)
  # chars = ['0'..'9', 'A'..'Z', ’a’..’z’].map { |range| range.to_a }.flatten
  # self.short_url = 6.times.map{chars.sample}.join until Url.find_by_short_url(self.short_url).nil?
  self.short_url = "#{self.id}url"
end

private

def url_params
 params.require(:url).permit(:long_url)
rescue
  {}
end
end
