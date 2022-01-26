// This triguer is to generate the obstacles and saving them
trigger ObstaclesGenerationTrigger on Board__c (after insert) {
    Board__c mainBoard;
    for(Board__c board : Trigger.new){
        mainBoard = board;
    }
    
    List<Obstacle__c> obstacles = ObstaclesService.generateObstacles(mainBoard);
    
    insert obstacles;

}