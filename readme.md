tic tac toe game in a console

2 human players 
a board with zeros and crosses displayed after each turn 
scores for each player and message to tell the winner when the round is over
a game loop that can be finished 

 - an infinite loop with a stop word asked each time when the round is over
 - 2 human players with a name at the start of the game 
 - select number of cells at the start of the game
 - show board with values for each cell with letters and numbers at the left and top of the board 
 - create logics on how to define check if a use wins after each user turn 
 - tell user instructions on how to define bid position 
 - 

A user
 - name
 - peg 
 - score 
 - make a turn to define bid position

A board 
 - number of cells
 - show an empty board at a round start 
 - show x or o after a user bid based on user 

A game 
 - round 


1. Make a board template show
  - number of rows -> from 3 to 9
2. Create 2 users with 
  - name
  - score
  - peg (the first user gets 'x' by default, the second - 'o')
3. Run a game
  - run a round
    * round has array cell number turns or until someone wins or until someone enters stop word 
      - if stop word -> show the scores and ask if 
        - stop a game
        - start a new round -> no scores added 
        - start a new game 



