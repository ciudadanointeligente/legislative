require 'billit_representers/models/bill_basic'

class Billit::BillBasic
  def icon
    if ! self.status.blank?
      case self.status.strip
      when "Archivado"
        return 'filed.png'
      when "Publicado"
        return 'published.png'
      when "En tramitación"
        return 'paperwork.png' #icono pendiente 
      when "Rechazado"
        return 'rejected.png' 
      when "Retirado"
        return 'discarded.png' 
      else
        return 'paperwork.png'
      end
    end
    return 'paperwork.png'
  end

  def web_url
    ENV['root_url'] + '/proyectos/' + self.uid
  end
end