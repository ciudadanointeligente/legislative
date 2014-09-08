class BillitPaperwork 
  def icon_event
    case self.timeline_status
    when "Ingreso"
      return "introduced.png"
    when "Avanza"
      return "go-forward.png"
    when "Indicaciones"
      return "directives.png"
    when "Votación"
      return "vote.png"
    when "Urgencia"
      return "priority.png"
    when "Rechazado"
      return "rejected.png"
    when "Insistencia"
      return "insistence.png"
    when "Descartado"
      return "discarded.png"
    when "Informe"
      return "report.png"
    when "Retiro de Urgencia"
      return "priority-withdrawal.png"
    when "Tramitación Terminada"
      return "published.png"
    else
      return "paperwork.png"
    end
  end
end
