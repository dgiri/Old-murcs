module StoriesHelper
  def filtered_stories(stories, current_state)
    filtered_stories = stories.select { |s| s.current_state == current_state }
    render :partial => "stories/stories", :locals =>{ :stories => filtered_stories }
  end
  
  def velocity
    @project.stories.sum(:estimate, :conditions => ["current_state = 'accepted' AND updated_at >= ?", (Project::ITERATION_LENGTH * 3).days.ago]) / 3 
  end
  
  def current_column(story)
    case story.current_state
    when 'icebox'
      'icebox'
    when 'backlog'
      'backlog'
    when 'started'
      'indev'
    when 'finished'
      'indev'
    when 'delivered'
      'indev'
    when 'rejected'
      'indev'
    when 'accepted'
      'done'
    end
    
  end
end
