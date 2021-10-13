open Pkmn
open Pokemon
open Items

(* For Printing*)
let pp_string s = "\"" ^ s ^ "\""

(** [pp_list pp_elt lst] pretty-prints list [lst], using [pp_elt]
    to pretty-print each element of [lst]. *)
let pp_list pp_elt lst =
  let pp_elts lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ ", ") t'
    in loop 0 "" lst
  in pp_elts lst

type turn =
  | ME
  | CPU

let num_of_moves_per_type = 2

let color_printer who str = match who with
  | ME -> ANSITerminal.(print_string [green] (str ^ "\n")) 
  | CPU -> ANSITerminal.(print_string [red] (str ^ "\n")) 

type difficulty = 
  | Easy
  | Medium
  | Hard

type cputype = 
  | Random
  | Offensive

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

let get_norm_mv () =
  Random.self_init ();
  List.nth norm_mvs (Random.int (List.length norm_mvs))

let get_fire_mv () = 
  Random.self_init ();
  List.nth fire_mvs (Random.int (List.length fire_mvs))

let get_water_mv () = 
  Random.self_init (); 
  List.nth water_mvs (Random.int (List.length water_mvs))

let get_grass_mv () =
  Random.self_init (); 
  List.nth grass_mvs (Random.int (List.length grass_mvs))

let rec get_elmental_moves (element : unit -> Pkmn.Pokemon.move) num mvs =
  if num > 0 then get_elmental_moves element (num-1) (element () :: mvs)
  else mvs

let create_moves pkmn = 
  match pkmn.elemental with 
  | Fire -> get_elmental_moves get_fire_mv num_of_moves_per_type [] @
            get_elmental_moves get_norm_mv num_of_moves_per_type []
  | Water -> get_elmental_moves get_water_mv num_of_moves_per_type [] @
             get_elmental_moves get_norm_mv num_of_moves_per_type []
  | Grass -> get_elmental_moves get_grass_mv num_of_moves_per_type [] @
             get_elmental_moves get_norm_mv num_of_moves_per_type []
  | Normal -> failwith "Not a valid pokemon type"


let p1_random_potion () = List.nth potions(Random.int (List.length potions))
let p1_random_poison () = List.nth poisons (Random.int (List.length poisons))
let p1_random_boost () = List.nth boosts (Random.int (List.length boosts))

let p1_random_items () =
  Random.self_init ();
  let items = [
    Potion (p1_random_potion ());
    Poison (p1_random_poison ());
    Boost (p1_random_boost ());
  ] in 
  items

let item_to_string item = match item with
  | Poison a -> a.poisonname
  | Potion a -> a.potionname
  | Boost a -> a.boostname

let your_items batt = 
  color_printer ME ("Your items are: " ^ (pp_list item_to_string batt.p1_items))

let generate () = 
  Random.self_init ();  
  let rand_fire = List.nth fire_pkmn (Random.int (List.length fire_pkmn)) in 
  let rand_water = List.nth water_pkmn (Random.int (List.length water_pkmn)) in 
  let rand_grass = List.nth grass_pkmn (Random.int (List.length grass_pkmn)) in 
  let rand1 = List.nth list_of_pkmn (Random.int (List.length list_of_pkmn)) in 
  let rand2 = List.nth list_of_pkmn (Random.int (List.length list_of_pkmn)) in 
  let rand3 = List.nth list_of_pkmn (Random.int (List.length list_of_pkmn)) in 
  let your_pkmn = [rand1; rand2; rand3; rand_fire; rand_water; rand_grass] in 
  your_pkmn 



let init_battle diff =
  match diff with 
  | Easy -> begin
      let p1_pokemon = generate () in
      let p2_pokemon = generate () in
      {
        p1_pkmn_alive = p1_pokemon; 
        p1_pkmn_in_battle = p1_pokemon |> List.hd;   
        p1_current_health = 5.0; 
        p1_current_moveset = create_moves (p1_pokemon |> List.hd); 
        p1_items = p1_random_items ();
        p1_boost_mult = 1.0;

        p2_pkmn_alive = p2_pokemon; 
        p2_pkmn_in_battle = p2_pokemon |> List.hd;  
        p2_current_health = 5.0; 
        p2_current_moveset = create_moves (p2_pokemon |> List.hd); 

        opponent_difficulty = diff;
      }
    end
  | Medium -> begin
      let p1_pokemon = generate () in
      let p2_pokemon = generate () in
      {
        p1_pkmn_alive = p1_pokemon; 
        p1_pkmn_in_battle = p1_pokemon |> List.hd;   
        p1_current_health = 8.0; 
        p1_current_moveset = create_moves (p1_pokemon |> List.hd); 
        p1_items = p1_random_items ();
        p1_boost_mult = 1.0;

        p2_pkmn_alive = p2_pokemon; 
        p2_pkmn_in_battle = p2_pokemon |> List.hd;  
        p2_current_health = 8.0; 
        p2_current_moveset = create_moves (p2_pokemon |> List.hd); 

        opponent_difficulty = diff;
      }
    end
  | Hard -> begin
      let p1_pokemon = generate () in
      let p2_pokemon = generate () in
      {
        p1_pkmn_alive = p1_pokemon; 
        p1_pkmn_in_battle = p1_pokemon |> List.hd;   
        p1_current_health = 8.0; 
        p1_current_moveset = create_moves (p1_pokemon |> List.hd); 
        p1_items = p1_random_items ();
        p1_boost_mult = 1.0;

        p2_pkmn_alive = p2_pokemon; 
        p2_pkmn_in_battle = p2_pokemon |> List.hd;  
        p2_current_health = 8.0; 
        p2_current_moveset = create_moves (p2_pokemon |> List.hd); 

        opponent_difficulty = diff;
      }
    end

let get_p1_pkmn_alive batt = 
  batt.p1_pkmn_alive 

let get_p2_pkmn_alive batt = 
  batt.p2_pkmn_alive 

let get_p1_current_health batt = 
  batt.p1_current_health 

let get_p2_current_health batt = 
  batt.p2_current_health 

let outcome p1_pkmn p2_pkmn = 
  if p1_pkmn = [] && p2_pkmn = [] 
  then print_endline "It's a draw!"
  else if p1_pkmn = [] 
  then color_printer CPU "You were defeated!"
  else if p2_pkmn= [] 
  then color_printer ME "You have won!"
  else print_endline "It is your turn."

let faint_pkmn_p1 batt = 
  if batt.p1_current_health <= 0.0 
  then match batt.p1_pkmn_alive with 
    | [] -> []
    | h :: [] -> []
    | h :: t -> t
  else batt.p1_pkmn_alive

let faint_pkmn_p2 batt = 
  if batt.p2_current_health <= 0.0 
  then match batt.p2_pkmn_alive with 
    | [] -> []
    | h :: [] -> []
    | h :: t -> t
  else batt.p2_pkmn_alive

let cycle_pkmn_p1 batt = 
  batt.p1_pkmn_in_battle <- (batt.p1_pkmn_alive |> List.hd);
  batt.p1_boost_mult <- 1.0

let cycle_pkmn_p2 batt =  
  batt.p2_pkmn_in_battle <- (batt.p2_pkmn_alive |> List.hd) 

let regen_health_p1 batt = 
  match batt.opponent_difficulty with
  | Easy -> 
    batt.p1_current_health <- 5.0;
    batt.p1_boost_mult <- 1.0  
  | Medium | Hard -> 
    batt.p1_current_health <- 8.0;
    batt.p1_boost_mult <- 1.0 

let regen_health_p2 batt = 
  batt.p2_current_health <- 5.0  


let new_moves_p1 batt = 
  batt.p1_current_moveset <- create_moves batt.p1_pkmn_in_battle

let new_moves_p2 batt = 
  batt.p2_current_moveset <- create_moves batt.p2_pkmn_in_battle

let my_pokemon_died batt = match batt.p1_pkmn_alive with
  | [] -> print_endline "\nYour pokemon has fainted. You have no pokemon left"
  | hd :: tl -> print_endline "\nYour pokemon has fainted."; 
    color_printer ME ("You sent out " ^ hd.name)

let cpu_pokemon_died batt = match batt.p2_pkmn_alive with
  | [] -> print_endline "\nTheir pokemon has fainted. They have no pokemon left"
  | hd :: tl -> print_endline "\nTheir pokemon has fainted."; 
    color_printer CPU ("They sent out " ^ hd.name)

let update_pkmn_p1 batt = 
  let temp = List.length batt.p1_pkmn_alive in 
  batt.p1_pkmn_alive <- faint_pkmn_p1 batt;
  if List.length batt.p1_pkmn_alive = 0
  then my_pokemon_died batt
  else if List.length batt.p1_pkmn_alive < temp
  then (cycle_pkmn_p1 batt; regen_health_p1 batt; new_moves_p1 batt; 
        my_pokemon_died batt)
  else cycle_pkmn_p1 batt

let update_pkmn_p2 batt = 
  let temp = List.length batt.p2_pkmn_alive in 
  batt.p2_pkmn_alive <- faint_pkmn_p2 batt;
  if List.length batt.p2_pkmn_alive = 0 
  then cpu_pokemon_died batt 
  else if List.length batt.p2_pkmn_alive < temp 
  then (cycle_pkmn_p2 batt; regen_health_p2 batt; new_moves_p2 batt; 
        cpu_pokemon_died batt)
  else cycle_pkmn_p2 batt

let acceptable_attack batt user_inp =
  let acceptable_condition (move : move) = 
    if move.name = user_inp then true else false in
  List.exists acceptable_condition batt.p1_current_moveset

let remove_potion batt potion = 
  let condition item = match item with
    | Potion a -> potion <> a
    | _ -> true
  in
  batt.p1_items <- List.filter (condition) batt.p1_items

let remove_poison batt poison = 
  let condition item = match item with
    | Poison a -> poison <> a
    | _ -> true
  in
  batt.p1_items <- List.filter (condition) batt.p1_items

let remove_boost batt boost = 
  let condition item = match item with
    | Boost a -> boost <> a
    | _ -> true
  in
  batt.p1_items <- List.filter (condition) batt.p1_items

let p1_apply_potion batt potion = 
  batt.p1_current_health <- batt.p1_current_health +. potion.recovery;
  remove_potion batt potion

let p1_apply_poison batt poison= 
  batt.p2_current_health <- batt.p2_current_health -. poison.damage;
  remove_poison batt poison

let p1_apply_boost batt boost= 
  batt.p1_boost_mult <- boost.multiplier;
  remove_boost batt boost

let string_to_move batt user_inp = 
  let mv = 
    List.find_opt 
      (fun (elmt : move) -> user_inp = elmt.name) batt.p1_current_moveset in
  match mv with 
  | Some a -> a
  | None -> failwith "shouldn't get here"

type besttype = 
  | MyType
  | NormalType
  | Either

(* The move type1 should use against type2 for the most damage *)
let effective_against type1 type2 = match type1 , type2 with 
  | Water, Fire | Fire, Grass | Grass, Water -> MyType
  | Fire, Water | Grass, Fire | Water, Grass -> NormalType
  | _ -> Either

(* to be inputted into p2_attack *) 
let rec p2_rand_move batt = 
  Random.self_init ();
  match batt.opponent_difficulty with 
  | Easy -> 
    List.nth batt.p2_current_moveset (Random.int num_of_moves_per_type * 2)
  | Medium -> 
    List.nth batt.p2_current_moveset (Random.int num_of_moves_per_type * 2)
  | Hard -> get_dangerous_move batt

and get_dangerous_move batt = 
  let player_type = batt.p1_pkmn_in_battle.elemental in
  let cpu_type = batt.p2_pkmn_in_battle.elemental in 
  if effective_against cpu_type player_type = MyType 
  then List.find (fun (mv : move) -> mv.element = cpu_type) 
      batt.p2_current_moveset
  else if effective_against cpu_type player_type = NormalType 
  then List.find (fun (mv : move) -> mv.element = Normal) 
      batt.p2_current_moveset
  else List.nth batt.p2_current_moveset (Random.int num_of_moves_per_type * 2)

(** Calculates the damage each move does on an opposing pokemon based on the 
     move type and the opposing pokemon's type *) 
let damage_calc (move : move) (pkmn : pkmn) = 
  let neff = "Not very effective..." in
  let eff = "Effective!" in
  let seff = "Super Effective!!!" in
  match move.element with 
  | Fire -> begin
      match pkmn.elemental with
      | Water -> print_endline neff; 0.5
      | Grass -> print_endline seff; 2.0
      | _ -> print_endline eff; 1.0
    end
  | Water -> begin
      match pkmn.elemental with
      | Fire -> print_endline seff; 2.0
      | Grass -> print_endline neff; 0.5
      | _ -> print_endline eff; 1.0
    end
  | Grass -> begin 
      match pkmn.elemental with
      | Fire -> print_endline neff; 0.5
      | Water -> print_endline seff; 2.0
      | _ -> print_endline eff; 1.0
    end
  | Normal -> print_endline eff; 1.0

let real_damage batt (move : move) (pkmn : pkmn) =
  batt.p1_boost_mult *. damage_calc move pkmn

let p1_attack batt move = 
  let move_dmg = real_damage batt move batt.p2_pkmn_in_battle in 
  batt.p2_current_health <- batt.p2_current_health -. move_dmg 

let p2_attack batt move = 
  let move_dmg = real_damage batt move batt.p1_pkmn_in_battle in 
  batt.p1_current_health <- batt.p1_current_health -. move_dmg 

(* Dynamically prints all of your pokemon*)
let your_pkmn batt = 
  let names = List.map (fun (pkm : pkmn) -> pkm.name) batt.p1_pkmn_alive in 
  let str_of_names = pp_list pp_string names in
  color_printer ME ("\nYour pokemon are " ^ str_of_names)

(* Dynamically prints all of your opponent's pokemon*)      
let cpu_pkmn batt = 
  let names = List.map (fun (pkm : pkmn) -> pkm.name) batt.p2_pkmn_alive in 
  let str_of_names = pp_list pp_string names in
  color_printer CPU ("\nYour opponent's pokemon are " ^ str_of_names)

let your_moves batt = 
  let names = List.map (fun (mv : move) -> mv.name) batt.p1_current_moveset in 
  let str_of_names = pp_list pp_string names in
  color_printer ME ("\nYour current moves are " ^ str_of_names)

let trainers_begin batt = 
  let p1 = List.hd batt.p1_pkmn_alive in 
  let p1_str = p1.name in 
  let p2 = List.hd batt.p2_pkmn_alive in 
  let p2_str = p2.name in 
  your_pkmn batt;
  cpu_pkmn batt;
  print_endline "";
  color_printer ME ("You sent out " ^ p1_str);
  color_printer CPU ("The opponent sent out " ^ p2_str)