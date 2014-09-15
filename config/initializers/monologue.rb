Monologue.config do |config|
  config.site_name = "Congreso Abierto"
  config.site_subtitle = "-"
  config.site_url = "/"

  config.meta_description = ""
  config.meta_keyword = ""

  config.admin_force_ssl = false
  config.posts_per_page = 10

  config.disqus_shortname = "congresoabierto"

  # LOCALE
  config.twitter_locale = "es" # "fr"
  config.facebook_like_locale = "es_CL" # "fr_CA"
  config.google_plusone_locale = "es"

  # config.layout               = "layouts/application"

  # ANALYTICS
  # config.gauge_analytics_site_id = "YOUR COGE FROM GAUG.ES"
  # config.google_analytics_id = "YOUR GA CODE"

  config.sidebar = ["categories", "tag_cloud"]


  #SOCIAL
  config.twitter_username = "ciudadanoi"
  config.facebook_url = "https://www.facebook.com/ciudadanointeligente"
  config.facebook_logo = 'logo.png'
  config.google_plus_account_url = "https://plus.google.com/107619558104056675526/posts"
  #config.linkedin_url = "http://www.linkedin.com/in/jipiboily"
  config.github_username = "ciudadanointeligente"
  #config.show_rss_icon = true

end