module BillsHelper
  def get_params url
    uri = URI::parse(url)
    uri.query
  end
end
