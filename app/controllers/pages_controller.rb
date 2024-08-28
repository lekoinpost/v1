class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms_and_conditions, :robots, :faq, :faq_for_gardens ]

  def home
  end

  def terms_and_conditions
  end

  def robots
    robots = "User-Agent: *
      Disallow: ?address=*
      Disallow: ?button=*
      Disallow: */mon-compte/*
      Disallow: */admin/*
      Disallow: */messagerie/*
      Sitemap: '#{root_url}sitemap.xml'"

    render plain: robots, layout: false, content_type: "text/plain"
  end

  def faq
  end

  def faq_for_gardens
  end

end
