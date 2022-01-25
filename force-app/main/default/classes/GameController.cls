public with sharing class GameController {
    @RemoteAction
    public static List<Player__c> initGame(Integer width, Integer height, Integer playerCount){
        Board__c board = new Board__c(Width__c = width, Height__c = height);
        insert board;

        List<Player__c> players = new List<Player__c>();
        for(Integer i = 0; i < playerCount; i++){
            players.add(new Player__c(Position__c = 0, Number__c = i + 1));
        }

        insert players;
        
        players = Database.query('SELECT Number__c, Position__c FROM Player__c');

        return players;
    }
}
