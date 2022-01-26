@IsTest
public with sharing class GameControllerTest {
    @IsTest
    static void validateGameInitialization(){
        
        Test.startTest();
        String result = GameController.initGame(10, 10, 2);
        System.assert(result.length() > 0);
        Test.stopTest();
        
    }
}