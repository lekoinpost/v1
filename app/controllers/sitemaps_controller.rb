class SitemapsController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :show]
  layout :false
  before_action :init_sitemap
  
  def show
    @gardens = Garden.all
  end
  
  private

  def init_sitemap
    headers['Content-Type'] = 'application/xml'
  end
  
end