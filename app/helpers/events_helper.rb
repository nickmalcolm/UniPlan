module EventsHelper
  
  def id_of(event)
    "#{event.starts_at.strftime('%A_%l')}"
  end
  
end
