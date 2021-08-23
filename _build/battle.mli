open Pkmn
open Pokemon 
open Items
(** [difficulty] represents game difficulty. On Easy opponent will have 
    pokemon with health = 5.0 each and the moves selected will be random. On 
    Medium opponent will have pokemon with health = 8.0 each and the moves 
    selected will be random.On Hard opponent’s pokemon will have health = 8.0 
    each and the moves selected will be the most effective one. *)
type difficulty = 
  | Easy
  | Medium
  | Hard

(** [turn] represents who's turn it is. ME is the player1. CPU is player2 *)
type turn =
  | ME
  | CPU

type cputype = 
    | Random
    | Offensive

(** [color_printer turn string] prints string in green if it's player 1's turn
    prints it in red if it's player 2's turn *)
val color_printer : turn -> string -> unit

(** [battle] represents the data necesary to keep track of an ongoing battle 
via mutable represe *)
type battle = {
  mutable p1_pkmn_alive : pkmn list; 
  mutable p1_pkmn_in_battle : pkmn; 
  mutable p1_current_health : float; 
  mutable p1_current_moveset : move list; 
  mutable p1_items : item list;
  mutable p1_boost_mult : float;

  mutable p2_pkmn_alive : pkmn list; 
  mutable p2_pkmn_in_battle : pkmn; 
  mutable p2_current_health : float; 
  mutable p2_current_moveset : move list; 

  opponent_difficulty : difficulty;
}

(** [generate] generates a list for player 1's pokemon with 3 completely random 
    pokemon and 3 random pokemon of fire water and grass types  *)
val generate : unit -> pkmn list

(** [p1_random_items] gives the player 3 random items to use *) 
val p1_random_items : unit -> item list

(** [your_items] prints out your current items *)
val your_items : battle -> unit

(** [init_battle assoc_lst1 assoc_lst2 diff]  *)
val init_battle : difficulty -> battle

(** [get_p1_pkmn_alive batt] gets list of living pokemon for player1 *)
val get_p1_pkmn_alive : battle -> pkmn list  

(** [get_p1_pkmn_alive batt] gets list of living pokemon for player2 *)
val get_p2_pkmn_alive : battle -> pkmn list 

(** [get_p1_current_health] gets health of player1's current pokemon *)
val get_p1_current_health : battle -> float 

(** [get_p2_current_health] gets health of player2's current pokemon *)
val get_p2_current_health : battle -> float 

(** [faint_pkmn_p1 batt] updates the user's list of pokemon that are still 
    alive in battle [batt]. If the user's current pokemon has fainted, then the 
    player's pokemon is updated to a list that contains all of the player's 
    pokemon except for the one that has fainted. *)
val faint_pkmn_p1 : battle -> pkmn list 

(** removes pokemon from p1_pkmn_alive if health reaches 0 leaves p1_pkmn_alive
    unchanged otherwise *)
val faint_pkmn_p2 : battle -> pkmn list 

(** [cycle_pkmn_p1 batt] switches the pokemon that the user currently has in 
    battle [batt] to another pokemon. If this is the user's last pokemon, then 
    the user's pokemon in battle is set to an empty list. *)
val cycle_pkmn_p1 : battle -> unit

(** [cycle_pkmn_p2 batt] switches the pokemon that the opponent currently has 
    in battle [batt] to another pokemon. If this is the opponent's last 
    pokemon, then the opponent's pokemon in battle is set to an empty list. *)
val cycle_pkmn_p2 : battle -> unit

(** [regen_health_p1 batt] sets the user's health to full health in battle 
    [batt]. *)
val regen_health_p1 : battle -> unit

(** [regen_health_p2 batt] sets the opponents's health to full health in battle 
    [batt]. *)
val regen_health_p2 : battle -> unit

(** [new_moves_p1 batt] sets the user's available moves in battle [batt] to the 
    user's current list of available moves. *)
val new_moves_p1 : battle -> unit

(** [new_moves_p2 batt] sets the opponent's available moves in battle [batt] to 
    the user's current list of available moves. *)
val new_moves_p2 : battle -> unit

(** [update_pkmn_p1 batt] updates [p1_pkmn_alive] using [faint_pkmn_p1]
    and executes [my_pokemon_died] if length of [p1_pkmn_alive] is zero. cycles to 
    the next pokemon, regenerates health and gets moves of next pokemon if previous 
    pokemon fainted  *)
val update_pkmn_p1 : battle -> unit  

(** [update_pkmn_p1 batt] updates [p2_pkmn_alive] using [faint_pkmn_p2]
    and executes [my_pokemon_died] if length of [p2_pkmn_alive] is zero. cycles to 
    the next pokemon, regenerates health and gets moves of next pokemon if previous 
    pokemon fainted  *)
val update_pkmn_p2 : battle -> unit

(** [acceptable_attack batt user_inp] is true if [user_inp] a valid 
    attack, false otherwise *)
val acceptable_attack : battle -> string -> bool 

(** [string_to_move batt user_inp] turns inputed string into a type move *)
val string_to_move : battle -> string -> move 

(** [p2_rand_move batt] randomly selects a move from player 2's current 
    pokemon's moveset *)
val p2_rand_move : battle -> move 

(** [p1_attack] applies the move [move] in battle [batt] to player 2's 
    current pokemon; changes the health of that pokemon to reflect the 
    attack. *)
val p1_attack : battle -> move -> unit

(** [p2_attack] applies the move [move] in battle [batt] to player 1's 
    current pokemon; changes the health of that pokemon to reflect the 
    attack. *)
val p2_attack : battle -> move -> unit

(** [trainers_begin] prints statement that let's the user know which pokemon 
    they sent into battle and which pokemon their opponent sent into battle. *)
val trainers_begin : battle -> unit

(** [your_pkmn batt] prints statement that shows the user a list of all of 
    their pokemon. *)
val your_pkmn : battle -> unit

(** [your_moves batt] prints statement that shows the user a list of all of 
    their moves. *)
val your_moves : battle -> unit

(** [apply_potion batt potion] applies a potion to the using pokemon
    Potions do instant health regeneration, and does not take your turn *)
val p1_apply_potion : battle -> potion -> unit

(** [apply_poison batt poison] applies a poison to the opposing pokemon
    Poison does instant damage, and does not take your turn *)
val p1_apply_poison : battle -> poison -> unit

(** [apply_boost batt boost] applies a boost to the using pokemon
    Boost provides an attack multiplier for 1 turn, and does not 
    take your turn *)
val p1_apply_boost : battle -> boost -> unit
