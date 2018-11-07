public class MemberController {
    
	private String selectedQueueId = System.currentPageReference().getParameters().get('Id');

    public List<User> getResult(){
   
        return [SELECT id, name FROM User WHERE Id IN (SELECT UserOrGroupId FROM GroupMember WHERE Group.Id = :this.selectedQueueId)];
    } 
    
}