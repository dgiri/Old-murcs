require 'test_helper'
class NotifierTest < ActionMailer::TestCase

   context "Membership invitation" do
     setup do  
       setup_roles  
       @sender_user = Factory(:user)  
       @recipient_user = Factory(:user) 
       @story = Factory(:story)
       @project = Factory(:project) 
       membership = Factory(:membership, :user => @recipient_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => @sender_user, :recipient_email => @recipient_user.email)   
       Notifier.deliver_membership_invitation(membership)   
     end                                
     
     should 'send an invitation email' do 
       assert_sent_email do |email|       
         email.subject == 'Membership invitation' && email.to.include?(@recipient_user.email)
       end  
     end         
   end  
  
end
