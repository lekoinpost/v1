class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms_and_conditions ]

  def home
  end

  def terms_and_conditions
  end
end
