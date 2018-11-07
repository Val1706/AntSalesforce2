public with sharing class QueueGenerator {

	private List <User> members =  [SELECT id FROM User WHERE CompanyName = 'GE'];
	private List <Group> queues = new List<Group>();
	private List <QueueSObject> queueSobjs = new List<QueueSObject>();
	private List <GroupMember> grMembers = new List<GroupMember>();
	private Integer queueAmount = 250;
    private Integer membersSize = members.size();

	public void generateQueues(){

		for(Integer i=0; i<queueAmount; i++){
			Group g = new Group(Type='Queue', Name='CustomQueue' + i);
			queues.add(g);
		}
		
		insert this.queues;

		List<Group> insertedQueues = [SELECT Id FROM Group WHERE Name LIKE 'CustomQueue%'];

		for(Integer i = 0; i < insertedQueues.size(); i ++){
	        QueueSObject queueS = new QueueSObject(SobjectType='Invoice_Header__c', QueueId=insertedQueues.get(i).Id);
            queueSobjs.add(queueS);
            
            for(Integer k = 0; k < (Math.random() * (membersSize));  k++){
                GroupMember member = new GroupMember();
                member.UserOrGroupId = members.get(Math.Mod((k), membersSize)).Id;
                member.GroupId = insertedQueues.get(i).Id;
                grMembers.add(member);
            }  
		}
        insert this.queueSobjs;
		insert this.grMembers;
	}
    
    public void removeQueues(){
        
        List<Group> queuesToRemove = [SELECT Id FROM Group WHERE Type='Queue'];
        delete queuesToRemove;
    }
    
    
}