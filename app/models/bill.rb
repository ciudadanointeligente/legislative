require 'roar/representer/feature/client'
require 'billit_representers/representers/bill_representer'

class Bill
  include Billit::BillRepresenter

  # FIXME: why can't we override #id here?
  def id
    links[:self].href
  end
  
  def url
    links[:self].href
  end

  def to_param
    CGI::escape(url)
  end

  def self.from_param(param)
    find_by_id(param)
  end

  def persisted?
    @persisted
  end
  
  def errors
    []
  end

  def web_url
    ENV['root_url'] + 'bills/' + self.uid
  end
end
