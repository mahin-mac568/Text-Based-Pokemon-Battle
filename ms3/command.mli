open Items 

(** The type [command] represents a player's inputted command that is 
    decomposed into an action and possibly a move. Attack should wrap a list 
    with just one string element -- that string being the move. *)
type command = 
  | Attack of string list 
  | Use of item 
  | Forfeit 

(** Raised when nothing is inputted *)
exception EmptyCommand 

(** Raised when no move is inputted after "attack" *)
exception EmptyMove 

(** Raised when no item is inputted after "use" *)
exception EmptyUse

(** Raised when the first word of the command is not "attack". Also raised 
    when the word "forfeit" is followed by another word. *)
exception Invalid_Command

(** Raised when the word after "attack" is not a move *)
exception Invalid_Move

(** Raised when the word after "use" is not an item *)
exception Invalid_Item

(** Raised when the potion is not an item you have *)
exception Invalid_Potion

(** Raised when the poison is not an item you have *)
exception Invalid_Poison

(** Raised when the boost is not an item you have *)
exception Invalid_Boost

(** [parse_command curr_mvs str] parses a player's input into a [command] as 
    follows. The first word (i.e., a  consecutive sequence of non-space 
    characters) of [str] becomes the action. The second wor, if it exists, 
    becomes the move -- iff that move is currently an available move. An 
    available move is one that the pokemon currently in battle has access to. 

    Examples: 
    - [parse "    attack   water_gun  "] is [Attack ["water_gun"]]
    - [parse "attack flare_blitz"] is [Attack ["flare_blitz"]]
    - [parse "forefeit"] is [Forfeit]. 

    Requires: [str] contains only lowercase alphabet characters and spaces 
    (only ASCII character code 32), and may contain one underscore (a-z, _). 

    Raises: [EmptyCommand] if nothing is inputted

    Raises: [EmptyMove] if no move is inputted after "attack"

    Raises: [Invalid_Command] if the first word of the command is not "attack". 
    Also raised when the word "forfeit" comes before another word.

    Raises: [Invalid_Move] if the word after "attack" is not a move.  *)
val parse : Battle.battle -> string -> command