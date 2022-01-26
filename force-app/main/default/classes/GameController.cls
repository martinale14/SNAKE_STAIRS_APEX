public with sharing class GameController {
    @RemoteAction
    public static String initGame(Integer width, Integer height, Integer playerCount){
        Board__c board = new Board__c(Width__c = width, Height__c = height);

        insert board;

        List<Obstacle__c> obstacles = [SELECT Type__c, From__c, To__c FROM Obstacle__c WHERE Board__r.Id = :board.id];

        List<Player__c> players = new List<Player__c>();
        for(Integer i = 0; i < playerCount; i++){
            players.add(new Player__c(Position__c = 0, Number__c = i + 1, Board__c = board.Id));
        }

        insert players;

        board = [SELECT Size__c FROM Board__c WHERE Id = :board.Id];
        players = [SELECT Position__c, Number__c FROM Player__c WHERE Board__r.Id = :board.Id];

        List<Integer> places = new List<Integer>();
        Integer turn = 0;
        
        String gameResume = '';

        while(places.size() != players.size()){

            if(!places.contains(turn)){
                
                Player__c player = players[turn];
                
                Integer dieNumber = Die.roll();
                gameResume += 'The die rolls ' + dieNumber + '-';

                Integer initialPosition = player.Position__c.intValue();
                player.Position__c = initialPosition + dieNumber;

                if(player.Position__c > board.Size__c.intValue()){
                    Integer newPosition = (2 * board.Size__c.intValue()) - player.Position__c.intValue();
                    player.Position__c = newPosition < 0 ? 0 : newPosition;
                }

                for(Obstacle__c e : obstacles){
                    if(e.From__c == player.Position__c.intValue()){
                        gameResume += (e.From__c > e.To__c ? 'Oops you fall on an snake-' : 'Good Luck you can go up the stair-');
                        player.Position__C = e.To__c.intValue();
                        gameResume += String.format('{0} [from: {1}, to: {2}]-', new String[]{e.Type__c, String.valueOf(e.From__c), String.valueOf(e.To__c)});
                    }
                }

                Integer step = Math.abs(player.Position__c.intValue() - initialPosition);
                gameResume += String.format('The Player {0} {1} {2} position{3}-', new String[]{String.valueOf(player.Number__c), player.Position__c > initialPosition ? 'advances' : 'goes back', String.valueOf(step), step > 1 ? 's' : ''});
                gameResume += String.format('The Player {0} is now on {1}-', new String[]{String.valueOf(player.Number__c), String.valueOf(player.Position__c)});

                if((player.Position__c.intValue() == board.Size__c.intValue()) || (places.size() == (players.size() - 1))){
                    places.add(turn);
                    players[turn] = player;
                }

                gameResume += '-';

            }

            turn = turn == (players.size() - 1) ? 0 : (turn + 1);

        }

        update players;

        gameResume += '-';

        for(Integer i = 0; i < places.size(); i++){
            gameResume += String.format('{0}: Player {1} {2}-', new String[]{String.valueOf(i + 1), String.valueOf(places[i] + 1), i == 0 ? '(Winner)' : ''});
        }

        return gameResume;
    }
}