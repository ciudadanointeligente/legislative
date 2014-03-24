xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc ENV['root_url']
    xml.changefreq("daily")
    xml.priority 1.0
  end

  xml.url do
    xml.loc ENV['root_url'] + bills_path()
    xml.priority 1.0
  end

  xml.url do
    xml.loc ENV['root_url'] + congressmen_path()
    xml.priority 0.5
  end

  @congressmen.result.each do |congressman|
    xml.url do
      xml.loc ENV['root_url'] + congressman_path(congressman.id)
      xml.priority 0.5
    end
  end

  xml.url do
    xml.loc ENV['root_url'] + agendas_path()
    xml.changefreq("daily")
    xml.priority 1.0
  end

  xml.url do
    xml.loc ENV['root_url'] + communications_path()
    xml.priority 0.8
  end

  xml.url do
    xml.loc ENV['root_url'] + glossaries_path()
    xml.priority 0.3
  end
end