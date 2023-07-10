xml.instruct! :xml, version: '1.0'
xml.tag! 'urlset', 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc root_url
  end

  xml.url do
    xml.loc gardens_url
  end

  @gardens.each do |garden|
    xml.url do
      xml.loc garden_url(garden.slug)
      xml.lastmod garden.updated_at.strftime("%F")
    end
  end

  xml.url do
    xml.loc mentions_legales_url
  end


end
