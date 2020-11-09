Notes for OO Twenty-One Game

1.- Write a description of the problem and extract major nouns and verbs.
2.- Make an initial guess at organizing the verbs into nouns and do a spike to 
    explore the problem with temporary code.
3.- Optional - when you have a better idea of the problem, model your thoughts 
    into CRC cards. 
    
My Description:
- Twenty-One is a game that consists of a "dealer" and a "player". 
- The game starts by having the dealer take 4 cards out of a "deck" and 
  giving two cards to himself and two to the player. 
- The 52 card "deck" consists of 4 suits and 13 values
- The goal of the game is to get as close to 21 as possible without going over

Potential classes:
- Player
  - Hits
  - Stays

- Dealer
  - Deals
  - Shuffles deck
  
- Deck
  - Contains cards
  
- Orchestration Engine (TwentyOneGame)

LaunchSchool Description:

- Twenty-One is a card game consisting of a dealer and a player, 
  where the participants try to get as close to 21 as possible without going 
  over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, 
  then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

************************
***Potential Classes:***
************************
Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start
- 
********************
****After Spike:****
********************
- Extract redundant behaviors from Player and Dealer into Participant
- Determine "hand" structure
  - Empty array?
- Determine Structure to be used in deck
  - Possibly a hash
- Determine states within "card" class
  - Suit and value only?