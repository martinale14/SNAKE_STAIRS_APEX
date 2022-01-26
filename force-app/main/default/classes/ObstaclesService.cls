public with sharing class ObstaclesService {

    // Method to generate the obstacles of a giving board size
    public static List<Obstacle__c> generateObstacles(Board__c board){

        Integer size = board.Size__c.intValue();
        List<Obstacle__c> obstacles = new List<Obstacle__c>();
        List<Integer> used = new List<Integer>();
        Integer ctObstacle = (size * ((Math.random() * .25) + .15)).intValue();

        for(Integer i = 0; i < ctObstacle; i++){

            Integer fr = getRandomNumberNotIncluded(used, size - 1, 1);
            used.add(fr);
            Integer to = getRandomNumberNotIncluded(used, size - 1, 1);
            used.add(to);

            obstacles.add(new Obstacle__c(From__c = fr, To__c = to, Board__c = board.Id));

        }
        
        return obstacles;
    }

    // Method to get random numbers that are not included in a giving array of giving size
    public static Integer getRandomNumberNotIncluded(List<Integer> used, Integer max, Integer min){
        if(max - min == used.size()){
            throw new InfiniteLoopException('Warning preventing infinite loop');
        }

        Integer num;

        do {
            num = (Math.floor(Math.random() * (max - min)) + min).intValue();
        } while (used.contains(num));

        return num;
    }

    @TestVisible
    private class InfiniteLoopException extends Exception{}
}