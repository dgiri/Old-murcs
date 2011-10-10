# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  def created_on(data)
    data.strftime("%b %d, %Y, %R %p")
  end  
end
