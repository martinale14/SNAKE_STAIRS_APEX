@IsTest
public with sharing class GameControllerTest {

    // this test provide us a feedback about game main loop functionallity
    @IsTest
    static void validateGameInitialization(){
        
        Test.startTest();
        String result = GameController.initGame(10, 10, 2);
        System.assert(result.length() > 0);
        Test.stopTest();
        
    }
}