public with sharing class QueueController {
    private List<Group> queues = new List<Group>();
    private integer totalRecs = 0;
    private integer OffsetSize = 0;
    private integer LimitSize= 25;
    public String userInput{get;set;}

    
    public QueueController(){
        totalRecs = [select count() from Group WHERE Type = 'Queue'] - 1;
    }

    public List<Group> getAllQueues(){
 	
        if(userInput==NULL || userInput=='' ){
			 return [SELECT Id, Name FROM Group WHERE Type = 'Queue' ORDER BY CreatedDate LIMIT :LimitSize OFFSET :OffsetSize];
        }
        return [SELECT Id, Name FROM Group WHERE Type = 'Queue' AND Name LIKE :('%' + userInput + '%') ORDER BY CreatedDate LIMIT :LimitSize OFFSET :OffsetSize];
    	}
    
    public PageReference getMembers(){
        
        String selectedId = System.currentPageReference().getParameters().get('SelectedId');
        PageReference pageRef = new PageReference('/apex/MembersQueue?Id=' + selectedId);
        return pageRef;
    }
    
    public void FirstPage(){
        OffsetSize = 0;
    }
              
    public void previous(){
        OffsetSize = OffsetSize - LimitSize;
    }
    
    public void next(){
        OffsetSize = OffsetSize + LimitSize;
    }
    public void LastPage(){
        OffsetSize = totalrecs - math.mod(totalRecs,LimitSize);
    }
    
    public boolean getprev(){
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxt(){
        if((OffsetSize + LimitSize) > totalRecs)
            return true;
        else
            return false;
    }
}