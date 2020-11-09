
- Notes
- Write a program that determines whether the computer acts offensively or
  defensively
  - Offensively: If there are two computer markers in a winning line,
    apply marker to the empty line (' ') to win.
  - Defensively: If there are two human markers in a winning line, apply
    marker to empty line (' ') to prevent losing.

- Board#winning_marker already obtains a collection of all the markers
  within a winning line
  - We can modify method by looking at the markers in the winning line
    - We first look at the lines with computer markers
      - If the winning line array has two computer markers, add a computer
        marker to the empty index
    - If none of the lines have two computer markers, then look at the lines
      with human markers
      - If the winning line has two human markers, add a computer marker to
        the empty index

2.- Allow player to pick any marker
  - Write a method that asks if the player would like to pick the marker
    or stay with the default one

  ALGORITHM (Main method) (player_picks_marker?)
  - Ask player "Would you like to use the default marker (y/n)"
    - If the player answers yes:
      - Constant "HUMAN_MARKER" stays the same ("X")
    - If the player answers no:
      - call method TTTGame#change_player_marker

  ALGORITHM (Helper method - change_player_marker)
  - Ask player "Input desired marker (only one character long)"
    - Capture answer
    - Break out of loop if answer is 1 char long
    - Use replace method to change constant

3.- Set a name for the player and computer
  - name will be a state of player and computer object instances
  - Computer name will come from an array of names, and a random one
    will be selected when object is instantiated
  - Player name will be asked before game starts
