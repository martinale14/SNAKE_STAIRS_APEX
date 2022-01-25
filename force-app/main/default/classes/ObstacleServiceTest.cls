@IsTest
public with sharing class ObstacleServiceTest {
    @IsTest
    static void ifReturnEmpty(){
        
        Test.startTest();
        Board__c board = new Board__c(Width__c = 0, Height__c = 0, Size__c = 0);
        System.assertEquals(0, ObstaclesService.generateObstacles(board).size());
        Test.stopTest();
        
    }

    @IsTest
    static void ifLenghtIsLessThanHalfSize(){
        
        Test.startTest();
        Board__c board = new Board__c(Width__c = 10, Height__c = 10, Size__c = 100);
        for(Integer i = 0; i < 1000; i++){
            System.assert(ObstaclesService.generateObstacles(board).size() < 50);
        }
        Test.stopTest();
        
    }

    @IsTest
    static void validateRandomNumberWhitoutPosibilities(){
        
        Test.startTest();
        List<Integer> arr = new List<Integer>{1, 2, 3, 4, 5, 6, 7, 8, 9};
        try{
            ObstaclesService.getRandomNumberNotIncluded(arr, 10, 1);
        }catch(ObstaclesService.InfiniteLoopException e){
            System.assertEquals('Warning preventing infinite loop',  e.getMessage());
        }
        Test.stopTest();
        
    }

    @IsTest
    static void validateRandomNumberNotIncludedIsGot(){
        
        Test.startTest();
        List<Integer> arr = new List<Integer>{1, 2, 3, 4, 5, 7, 8, 9};
        System.assertEquals(6, ObstaclesService.getRandomNumberNotIncluded(arr, 10, 1));
        Test.stopTest();
        
    }

    @IsTest
    static void validateRandomNumberGeneration(){
        
        Test.startTest();
        List<Integer> arr = new List<Integer>();
        for(Integer i = 0; i < 9; i ++){
            Integer num = ObstaclesService.getRandomNumberNotIncluded(arr, 10, 1);
            System.assert(!arr.contains(num));
            arr.add(num);
            System.assert(num < 10 & num >= 1);
        }
        Test.stopTest();
        
    }
}
