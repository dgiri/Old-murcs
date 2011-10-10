class Notifier < ActionMailer::Base
  def membership_invitation(membership)      
    setup_email(membership)
    
    recipients  membership.recipient_email
    subject     "Membership invitation"
    body        :membership => membership 
  end
  
  def commnet_message_notification(story, comment, project)
    setup_email(story)
    recipients story.story_recipients(project, story)
    subject   "NEW COMMENT #{story.project.name}"
    body      :story => story, :comment => comment    
    
  end
  
  protected
    def setup_email(user)
      @from         = "Support <support@murcsloot.local>"
      headers         "Reply-to" => "support@murcsloot.local"
      @sent_on      = Time.zone.now
      @content_type = "multipart/alternative"
    end
end
