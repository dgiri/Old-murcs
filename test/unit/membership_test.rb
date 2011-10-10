require 'test_helper' 
class MembershipTest < ActiveSupport::TestCase 
  should_belong_to :sender
  should_belong_to :user
  should_belong_to :project
  should_belong_to :role
  
  should_validate_presence_of :recipient_email, :role_id
  
  context "Membership" do 
    context "A membership" do
      setup do
        Factory(:membership)
        subject { Membership.first }
      end

      should_validate_uniqueness_of :recipient_email, :scoped_to => [:project_id]
    end
    
    context "membername of member when user exists" do
      setup do     
        @user = Factory(:user)
        @member = Factory(:membership, :user => @user)
      end  
      
      should "return membername" do
        assert_equal "#{@user.username} <#{@user.email}>", @member.member_name  
      end
    end  
    
    context "membername of member when user doesn't exist" do
      setup do
        @member = Factory(:membership)
      end  
      
      should "return membername" do
        assert_equal @member.recipient_email, @member.member_name  
      end
    end 
    
    context "fullname of sender" do
      setup do 
        @sender = Factory(:user)
        @member = Factory(:membership, :sender => @sender)
      end

      should "return full name" do   
        assert_equal @sender.full_name, @member.sender_full_name        
      end
    end
         
    context "member activate" do
      setup do  
        @user = Factory(:user)
        @member = Factory(:membership)
        @member.activate!(@user)
      end

      should "set member user to the user parameter passed " do  
        assert_equal @user, @member.user 
      end   
      should "set token to nil" do  
        assert_equal nil, @member.token 
      end       
      should "set accepted at" do  
        assert_equal Time.now.to_date, @member.accepted_at.to_date
      end 
    end  
    
    context "is inactive" do
      setup do  
        @user = Factory(:user)
        @member = Factory(:membership)
      end
    
      should "return false" do  
        assert_equal false, @member.active?
      end
    end 
    
    context "is active" do
      setup do  
        @user = Factory(:user)
        @member = Factory(:membership)
        @member.activate!(@user)
      end 
      should "return true " do  
        assert_equal true, @member.active?
      end
    end 
    
    context "Role constant" do     
      setup do
        setup_roles  
      end
      should "define all roles" do      
        membership_roles = Membership.roles
        all_roles = Role.find(:all, :order => :title).map do |r|
              [r.title, r.id]
            end                                
        assert_equal all_roles, membership_roles
      end
    end 
  end 
end
