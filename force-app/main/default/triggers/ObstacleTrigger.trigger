trigger ObstacleTrigger on Obstacle__c (before insert) {
    for(Obstacle__c obstacle : Trigger.new){
        obstacle.Type__c = obstacle.To__c > obstacle.From__c ? 'stair' : 'snake';
    }
}