// this triguer is to add the size property for the board
trigger BoardTrigger on Board__c (before insert) {

    for(Board__c board : Trigger.new){
        board.Size__c = board.Width__c * board.Height__c;
    }


}