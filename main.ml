open Battle
open Command

let print_seperation () = ANSITerminal.(print_string [blue] "__________________\
                                                             _______________________________________________________________________\n")

type gamestatus = 
  | Won
  | Lost 
  | Playing

let print_win_loss current_state =
  let p1_pkmn_alive = get_p1_pkmn_alive current_state in  
  let p2_pkmn_alive = get_p2_pkmn_alive current_state in 
  if List.length p1_pkmn_alive > 0 && List.length p2_pkmn_alive = 0
  then (print_endline "\nYou have won! Congratulations!"; Won)
  else (print_endline "\nYou have been defeated. Sucks to be a loser!"; Lost)

let end_game_cond current_state = 
  let p1_pkmn_alive = get_p1_pkmn_alive current_state in  
  let p2_pkmn_alive = get_p2_pkmn_alive current_state in 
  if List.length p1_pkmn_alive > 0 && List.length p2_pkmn_alive > 0 
  then Playing
  else if List.length p1_pkmn_alive > 0 && List.length p2_pkmn_alive = 0
  then Won
  else Lost

let rec game_loop (current_state : Battle.battle) =
  your_moves current_state;
  your_items current_state; 
  print_endline "What will you do?\n";
  print_seperation ();
  try 
    let user_input = read_line () |> parse current_state in 
    print_seperation ();
    match user_input with 
    | Attack t -> begin 
        let move_string = List.hd t in 
        let p1_move = string_to_move current_state move_string in 
        color_printer ME ("\nYou used " ^ p1_move.name ^ "!"); 
        p1_attack current_state p1_move; 
        update_pkmn_p2 current_state; 
        if end_game_cond current_state = Playing then begin
          let p2_health = get_p2_current_health current_state in 
          let p2_health_str = string_of_float p2_health in 
          print_endline ("The opponent's health is " ^ p2_health_str); 
          let p2_move = p2_rand_move current_state in
          color_printer CPU ("\nThe opponent used " ^ p2_move.name ^ "!");  
          p2_attack current_state p2_move; 
          update_pkmn_p1 current_state;
          if end_game_cond current_state = Playing then begin
            let p1_health = get_p1_current_health current_state in 
            let p1_health_str = string_of_float p1_health in 
            print_endline ("Your health is " ^ p1_health_str); 
            game_loop current_state 
          end else print_win_loss current_state
        end else print_win_loss current_state
      end 


    | Forfeit ->
      print_endline "\nSo you're quitting. Sucks to be a loser!" ; Lost
    | Use item -> begin
        match item with 
        | Potion pt -> 
          (p1_apply_potion current_state pt); 
          color_printer ME ("You used " ^ pt.potionname);
          update_pkmn_p1 current_state;
          update_pkmn_p2 current_state;
          if end_game_cond current_state = Playing then begin
            let p1_health = get_p1_current_health current_state in 
            let p1_health_str = string_of_float p1_health in 
            print_endline ("Your health is " ^ p1_health_str);
            game_loop current_state 
          end else print_win_loss current_state
        | Poison ps -> 
          (p1_apply_poison current_state ps); 
          color_printer ME ("You used " ^ ps.poisonname);
          update_pkmn_p2 current_state;
          update_pkmn_p1 current_state;
          if end_game_cond current_state = Playing then begin
            let p2_health = get_p2_current_health current_state in 
            let p2_health_str = string_of_float p2_health in 
            print_endline ("The opponent's health is " ^ p2_health_str);
            game_loop current_state 
          end else print_win_loss current_state
        | Boost b -> 
          (p1_apply_boost current_state b); 
          color_printer ME ("You used " ^ b.boostname);
          update_pkmn_p2 current_state;
          update_pkmn_p1 current_state;
          if end_game_cond current_state = Playing then begin
            let p2_health = get_p2_current_health current_state in 
            let p2_health_str = string_of_float p2_health in 
            print_endline ("The opponent's health is " ^ p2_health_str);
            game_loop current_state 
          end else print_win_loss current_state
      end
  with 
  | EmptyCommand -> 
    print_endline "\nNothing was inputted. You're kind of slow aren't you?"; 
    game_loop current_state  
  | EmptyMove -> 
    print_endline "\nYou need to state a move after typing 'attack'"; 
    game_loop current_state 
  | Invalid_Command -> print_endline 
                         "\nThe first word of your command has to \
                          be 'attack' or you can type 'forfeit' to quit."; 
    game_loop current_state 
  | Invalid_Move -> 
    print_endline "\nYou need to type a valid move after the word 'attack'"; 
    game_loop current_state 
  | Invalid_Item ->
    print_endline "\nYou need to type a item type after the word 'use'";
    game_loop current_state
  | EmptyUse -> 
    print_endline "\nYou need to state an item after typing 'use'. Try again.";
    game_loop current_state
  | Invalid_Poison -> 
    print_endline "\nYou do not have that poison. Try again.";
    game_loop current_state
  | Invalid_Potion -> 
    print_endline "\nYou do not have that potion. Try again.";
    game_loop current_state
  | Invalid_Boost -> 
    print_endline "\nYou do not have that boost. Try again."; 
    game_loop current_state

let game_1 () = init_battle Easy

let game_2 () = init_battle Medium

let final_game () = init_battle Hard

let start_game state = (Battle.trainers_begin state)

let play_game start = 
  game_loop start

(** [main ()] prompts for the game to play, then starts it. *)

let print_instr () =
  let instr_string = 
    {|The game you are about to play consists of 3 battles. Try your best to be 
     the very best pokemon trainer! Here's some things you should know: 

    Each battle is harder than the last. The first battle is the easiest. Health
    is lower, and the CPU uses random attacks. The second battle has more 
    health, increasing your chances of losing. The third battle features a CPU 
    that always chooses the move that does the most damage to your pokemon. This
    will be your biggest challenge.

    In this game, you can either attack or use items. You can repeat attacks as
    much as you like. You can use items, but they expire after use. You will get
    three items at the beginning of each battle: one poison, one potion, and one
    boost.

    To use an available attack, type "attack [attack name here]"

    You can also use items! Items are in the order of [potion, poison, boost].

    To use a potion to heal, type "use potion [potion name here]"

    To use a poison against your opponent, type "use poison [poison name here]"

    To use a boost, type "use boost [boost name here]"

  Lastly, you can quit by typing "forfeit", but we don't like quitters.

  That's all. Good luck!|} in
  print_string instr_string

let play_from_start st = match start_game st with 
  | _ -> play_game st

let play_all_3_games () = 
  match play_from_start (game_1 ()) with  
  | Won -> begin match play_from_start (game_2 ()) with 
      | Won ->begin  match play_from_start (final_game ()) with
          | Won -> 
            print_endline
              "Congratulations on becoming the new Pokemon Champion!!"
          | Lost -> 
            print_endline"You came so close, you can't give up now!"
          | _ -> failwith "how'd this happen?"
        end
      | Lost -> 
        print_endline "You showed some skill, keep trying and maybe one day..."
      | _ -> failwith "how'd this happen?"
    end
  | Lost -> print_endline "Not everyone is meant to be a trainer..."
  | _ -> failwith "how'd this happen?"


let main () =
  ANSITerminal.(print_string [red]
                  "\n\nWelcome to the text-based Pokemon Game.\n\n");
  print_instr ();
  play_all_3_games ()

(* Execute the game engine. *)
let () = main ()