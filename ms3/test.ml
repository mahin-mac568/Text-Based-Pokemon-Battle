(** TEST PLAN

    We created OUnit tests for:

    THE BATTLE MODULE
    - used glassbox testing
    -   In the battle module, we have many tests that have a player 1 version  
        and a player 2 version (Some examples of these are get_pkmn_alive, 
        get_pkmn_health, cycle_pkmn, regen_health and new_moves). For each of 
        these, we create a testing function that tests both the player 1 and 
        player 2 version. The function differentiates between the player1 and 
        player2 versions by taking in a variant data type that is either 
        Player1 
        or Player2. 
    -   As far as the tests themselves, we had to do things a little differently
        compared to how we normally tested this semester. Many of our battle 
        function have a return type of unit. However, most of these funcitons 
        are alter the state of the battle. So to test these functions, we would 
        make function call and then subsequently check the state of the battle 
        to ensure the function is working correctly. 
        As an example of this: 
        When testing, cycle_pkmn_p1, we call cycle_pkmn_p1 and then check that 
        the pokemon currently in battle (batt.p1_pkmn_in_battle) is the correct 
        pokemon.
    -   For the functions that have non-unit return types, we had standard 
        functional programming tests like we conventionally had in other 
        assigments this semester.

    THE COMMAND MODULE
    -   The command functionality was predominantly tested through OUnit 
      tests. We made use of a parsing helper function to test many cases and 
      corner cases for what the user might input. There are tests for what the
      parse function outputs on a proper user input -- such as: attack 
      [available move], forfeit, and use [available item]. 
    -   We mostly used glassbox testing. Our tests were mainly derived from 
      data that we made ourselves and we made sure that our expected outputs 
      were in line with our program logic. 
    -   The tests we made for command demonstrate the correctness of our system
      because we account for nearly every case that a user can possibly input. 
      We confirm the effectiveness of the parse function by catching every form
      it can take: the tests recognize valid inputs for Attack, Use, and 
      Forfeit; the tests also recognize invalid inputs by catching exception 
      EmptyCommand, exception EmptyMove, exception, EmptyUse, exception 
      Invalid_Command, exception Invalid_Move, exception, Invalid_Item, 
      exception Invalid_Potion, exception Invalid_Poison, exception 
      Invalid_Boost.   

    THINGS WE MANUALLY TESTED: 
    -   We manually tested the functions that both had no return type and did 
      not change the state of the battle. For example, to test trainer's begin, 
      we simply looked at what was output to the terminal, as all the function 
      does is print.
    -   We also manually tested the game loop and many of the components that go 
      into the battle sequence in the main compilation unit by simply running 
      make play and playing the game

*)

open OUnit2
open Battle
open Pkmn
open Pokemon
open Command 
open Items 

(** These pretty print functions are meant to help us test the modules. 
    We did not put them in the battle.mli because they are not meant to 
    be public functions. *)

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

let pp_pkmn (p : pkmn) = "\"" ^ p.name ^ "\"" (* from A2 *)

let pp_move (m : move) = "\"" ^ m.name ^ "\""

(* pokemon; for testing purposes and easier readability *)
let charizard = {
  name = "charizard";
  elemental = Fire;
}
let incineroar = {
  name = "incineroar";
  elemental = Fire; 
}
let blastoise = {
  name = "blastoise";
  elemental = Water; 
}
let gryados = {
  name = "gryados";
  elemental = Water; 
}
let leafeon = {
  name = "leafeon";
  elemental = Grass; 
}
let roserade = {
  name = "roserade";
  elemental = Grass; 
}
let kartana = {
  name = "kartana";
  elemental = Grass; 
}
let ferrothorn = {
  name = "ferrothorn";
  elemental = Grass; 
}

(* moves; for testing purposes and easier readability *)
let flamethrower = {
  name = "flamethrower";
  element = Fire;
}
let flare_blitz = {
  name = "flare_blitz";
  element = Fire;
}
let leaf_storm = {
  name = "leaf_storm";
  element = Grass;
}
let leaf_tornado = {
  name = "leaf_tornado";
  element = Grass;
}
let slash = {
  name = "slash";
  element = Normal;
}
let cut = {
  name = "cut";
  element = Normal;
}
let body_slam = {
  name = "body_slam";
  element = Normal;
}
let headbutt = {
  name = "headbutt";
  element = Normal;
}
let flash = {
  name = "flash";
  element = Normal;
}
let seed_bomb = {
  name = "seed_bomb";
  element = Grass;
}
let foresight = {
  name = "foresight";
  element = Normal;
}
let heat_wave = {
  name = "heat_wave";
  element = Fire;
}
let flail = {
  name = "flail";
  element = Normal;
}
let magical_leaf = {
  name = "magical_leaf";
  element = Grass;
}
let feint = {
  name = "feint";
  element = Normal;
}

let p1_pokemon = [charizard; incineroar; blastoise; gryados; leafeon; roserade]
let p2_pokemon = [kartana; ferrothorn; incineroar; leafeon; gryados; blastoise]

let easy_battle1 = {
  p1_pkmn_alive = p1_pokemon; 
  p1_pkmn_in_battle = p1_pokemon |> List.hd;   
  p1_current_health = 5.0; 
  p1_current_moveset = [flamethrower; flare_blitz; slash; flash];
  p1_items = [];
  p1_boost_mult = 1.8;

  p2_pkmn_alive = p2_pokemon; 
  p2_pkmn_in_battle = p2_pokemon |> List.hd;  
  p2_current_health = 5.0; 
  p2_current_moveset = [leaf_storm; seed_bomb; headbutt; foresight]; 

  opponent_difficulty = Easy;
}

let easy_battle2 = {
  p1_pkmn_alive = p1_pokemon; 
  p1_pkmn_in_battle = p1_pokemon |> List.hd;   
  p1_current_health = 5.0; 
  p1_current_moveset = [flare_blitz; heat_wave; flail; body_slam];
  p1_items = [];
  p1_boost_mult = 2.;

  p2_pkmn_alive = p2_pokemon ; 
  p2_pkmn_in_battle = p2_pokemon |> List.hd;  
  p2_current_health = 5.0; 
  p2_current_moveset = [leaf_tornado; magical_leaf; feint; cut]; 

  opponent_difficulty = Easy;
}

type player = Player1 | Player2

let test_both_players player fun1 fun2 =
  match player with
  | Player1 -> fun1
  | Player2 -> fun2

let set_health batt player health =
  match player with
  | Player1 -> batt.p1_current_health <- health
  | Player2 -> batt.p2_current_health <- health

let get_pkmn_alive_test 
    (name : string)
    (batt : battle) 
    (player : player) 
    (expected_output : pkmn list) =
  let fun1 () = begin
    name >:: (fun _ ->
        assert_equal ~printer:(pp_list pp_pkmn) expected_output 
          batt.p1_pkmn_alive) 
  end in 
  let fun2 () = begin
    name >:: (fun _ ->
        assert_equal ~printer:(pp_list pp_pkmn) expected_output 
          batt.p2_pkmn_alive)
  end in
  test_both_players player (fun1 ()) (fun2 ())

let get_pkmn_current_health_test
    (name : string)
    (batt : battle) 
    (player : player) 
    (health : float) 
    (expected_output : float) =
  let fun1 () = begin
    name >:: (fun _ ->
        set_health batt player health;
        assert_equal ~printer:(string_of_float) expected_output 
          batt.p1_current_health) 
  end in 
  let fun2 () = begin
    name >:: (fun _ ->
        set_health batt player health;
        assert_equal ~printer:(string_of_float) expected_output 
          batt.p2_current_health)
  end in
  test_both_players player (fun1 ()) (fun2 ())

let faint_pkmn_test
    (name : string)
    (batt : battle) 
    (player : player) 
    (health : float) 
    (expected_output : pkmn list) =
  let fun1 () = begin
    name >:: (fun _ ->
        set_health batt player health;
        assert_equal ~printer:(pp_list pp_pkmn) expected_output 
          (faint_pkmn_p1 batt)) 
  end in 
  let fun2 () = begin
    name >:: (fun _ ->
        set_health batt player health;
        assert_equal ~printer:(pp_list pp_pkmn) expected_output 
          (faint_pkmn_p2 batt))
  end in
  test_both_players player (fun1 ()) (fun2 ())

let cycle_pkmn_test 
    (name : string)
    (batt : battle) 
    (player : player)
    (pkmns : pkmn list) 
    (expected_output : pkmn) =
  let fun1 () = begin 
    name >:: (fun _ ->
        batt.p1_pkmn_alive <- pkmns;
        cycle_pkmn_p1 batt;
        assert_equal ~printer:pp_pkmn expected_output batt.p1_pkmn_in_battle) 
  end in 
  let fun2 () = begin 
    name >:: (fun _ ->
        batt.p2_pkmn_alive <- pkmns;
        cycle_pkmn_p2 batt;
        assert_equal ~printer:pp_pkmn expected_output batt.p2_pkmn_in_battle)
  end in
  test_both_players player (fun1 ()) (fun2 ())

let regen_health_test 
    (name : string)
    (batt : battle) 
    (player : player)
    (move : move) 
    (expected_output : float) =
  let fun1 () = begin
    name >:: (fun _ ->
        p2_attack batt move;
        regen_health_p1 batt;
        assert_equal ~printer:string_of_float expected_output 
          batt.p1_current_health)
  end in
  let fun2 () = begin  
    name >:: (fun _ ->
        p1_attack batt move;
        regen_health_p2 batt;
        assert_equal ~printer:string_of_float expected_output 
          batt.p2_current_health)
  end in
  test_both_players player (fun1()) (fun2 ())

let pokemon_of_player player batt =
  match player with
  | Player1 -> batt.p1_pkmn_in_battle
  | Player2 -> batt.p2_pkmn_in_battle

let valid_moveset mvs batt player =
  match mvs with
  | [] -> failwith "Error: Moveset is empty"
  | sp1 :: sp2 :: norm1 :: norm2 :: [] -> begin
      let valid_sp = 
        let pkmn = pokemon_of_player player batt in
        match pkmn.elemental with
        | Fire -> List.mem sp1 fire_mvs && List.mem sp2 fire_mvs
        | Water -> List.mem sp1 water_mvs && List.mem sp2 fire_mvs
        | Grass -> List.mem sp1 grass_mvs && List.mem sp2 grass_mvs
        | Normal -> failwith "Error with moveset, first move should be 
                    an elemental move" in
      valid_sp && List.mem norm1 norm_mvs && List.mem norm2 norm_mvs
    end
  | _ -> failwith "Error: Shouldn't be possible. Check moveset."

let new_moves_test 
    (name : string)
    (batt : battle) 
    (player : player) 
    (expected_output : bool) = 
  name >:: (fun _ -> 
      let mvs = 
        match player with 
        | Player1 -> 
          new_moves_p1 batt;
          batt.p1_current_moveset
        | Player2 -> 
          new_moves_p2 batt;
          batt.p2_current_moveset in
      let valid = valid_moveset mvs batt player in
      assert_equal ~printer:string_of_bool expected_output 
        valid)

let acceptable_attack_test
    (name : string)
    (batt : battle) 
    (move : string) 
    (expected_output : bool) = 
  name >:: (fun _ ->
      assert_equal ~printer:string_of_bool expected_output 
        (acceptable_attack batt move))

let string_to_move_test
    (name : string)
    (batt : battle)
    (move : string)
    (expected_output : move) = 
  name >:: (fun _ ->
      assert_equal ~printer:pp_move expected_output 
        (string_to_move batt move))

let attack_test
    (name : string)
    (batt : battle) 
    (player : player) 
    (move : move)
    (expected_output : bool) =
  let fun1 () = begin
    name >:: (fun _ ->
        let health = batt.p2_current_health in
        p1_attack batt move;
        assert_equal ~printer:string_of_bool expected_output 
          (batt.p2_current_health < health)) 
  end in 
  let fun2 () = begin
    name >:: (fun _ ->
        let health = batt.p1_current_health in
        p2_attack batt move;
        assert_equal ~printer:string_of_bool expected_output 
          (batt.p1_current_health < health)) 
  end in
  test_both_players player (fun1 ()) (fun2 ())

let p2_rand_move_test
    (name : string)
    (batt : battle) 
    (expected_output : bool) =
    name >:: (fun _ ->
        let move = p2_rand_move batt in
        assert_equal ~printer:string_of_bool expected_output 
        (List.mem move batt.p2_current_moveset)) 

let battle_tests = [
  get_pkmn_alive_test "Player 1's Pokemon alive" 
    easy_battle1 Player1 p1_pokemon;
  get_pkmn_alive_test "Player 2's Pokemon alive" 
    easy_battle1 Player2 p2_pokemon;

  get_pkmn_current_health_test "Player 1's health" 
    easy_battle1 Player1 4.5 4.5;
  get_pkmn_current_health_test "Player 2's health" 
    easy_battle1 Player2 0.0 0.0;

  faint_pkmn_test "Player1's pokemon health of -1"
    easy_battle2 Player1 (-1.0) (List.tl p1_pokemon);
  faint_pkmn_test "Player1's pokemon health of -0.5" 
    easy_battle1 Player1 (-0.5) (List.tl p1_pokemon);
  faint_pkmn_test "Player1's pokemon health of 0" 
    easy_battle2 Player1 0.0 (List.tl p1_pokemon);  
  faint_pkmn_test "Player2's pokemon health of 0" 
    easy_battle2 Player2 0.0 (List.tl p2_pokemon);
  faint_pkmn_test "Player 1's pokemon has not fainted" 
    easy_battle2 Player1 5.0 p1_pokemon;
  faint_pkmn_test "Player 2's pokemon has not fainted" 
    easy_battle2 Player2 3.0 p2_pokemon;

  cycle_pkmn_test "Player 1 OG List" 
    easy_battle1 Player1 p1_pokemon charizard;
  cycle_pkmn_test "Player 2 OG List" 
    easy_battle1 Player1 p2_pokemon kartana;
  cycle_pkmn_test "Player 1 without first pokemon" 
    easy_battle1 Player1 (List.tl p1_pokemon) incineroar; 
  cycle_pkmn_test "Player 2 without first pokemon" 
    easy_battle1 Player2 (List.tl p2_pokemon) ferrothorn;

  regen_health_test 
    "Heal player 1's pokemon that was injured by effective attack" 
    easy_battle1 Player1 headbutt 5.0;
  regen_health_test 
    "Heal player 2's pokemon that was injured by super effective attack" 
    easy_battle1 Player2 flamethrower 5.0;
  regen_health_test 
    "Heal player 1's pokemon that was injured by a non-effective attack" 
    easy_battle1 Player1 leaf_storm 5.0;

  new_moves_test "Check validity of Player 1's new moveset" 
    easy_battle1 Player1 true;
  new_moves_test "Check validity of Player 2's new moveset" 
    easy_battle1 Player2 true;

  acceptable_attack_test "Valid Attack" 
    easy_battle2 "flail" true;
  acceptable_attack_test "Invalid Attack" 
    easy_battle1 "serious punch" false;

  string_to_move_test "An Elemental Move" 
    easy_battle2 "flare_blitz" flare_blitz;
  string_to_move_test "A Normal Move" 
    easy_battle2 "body_slam" body_slam;

  attack_test "Player 1 ; Elemental Attack" 
    easy_battle2 Player1 flare_blitz true;
  attack_test "Player 1 ; Normal Attack" 
    easy_battle2 Player1 body_slam true;
  attack_test "Player 2 ; Elemental Attack" 
    easy_battle2 Player2 leaf_tornado true;
  attack_test "Player 2 ; Normal Attack" 
    easy_battle2 Player2 cut true;

  p2_rand_move_test "P2 Rand_move: Random Test 1" 
    easy_battle1 true;
  p2_rand_move_test "P2 Rand_move: Random Test 2" 
    easy_battle2 true;
]

let parse_test 
    (name : string)
    (batt : Battle.battle)
    (str : string)
    (expected_output : command) : test =
  name >:: (fun _ -> assert_equal expected_output (parse batt str)) 

(** Due to mutability in our designs, this portion has to be reinstantiated 
    in order for the tests to pass. *)
let easy_battle1 = {
  p1_pkmn_alive = p1_pokemon; 
  p1_pkmn_in_battle = p1_pokemon |> List.hd;   
  p1_current_health = 5.0; 
  p1_current_moveset = [flamethrower; flare_blitz; slash; flash];
  p1_items = [];
  p1_boost_mult = 1.8;

  p2_pkmn_alive = p2_pokemon; 
  p2_pkmn_in_battle = p2_pokemon |> List.hd;  
  p2_current_health = 5.0; 
  p2_current_moveset = [leaf_storm; seed_bomb; headbutt; foresight]; 

  opponent_difficulty = Easy;
}

let command_tests = [

  parse_test "test valid elemental attack" 
    easy_battle1 "attack flamethrower" (Attack ["flamethrower"]);  

  parse_test "test valid normal attack" 
    easy_battle1 "attack slash" (Attack (["slash"])); 

  parse_test "test a valid elemental attack with spaces" 
    easy_battle1 "   attack    flamethrower   " (Attack ["flamethrower"]);   

  parse_test "test a valid normal attack with spaces" 
    easy_battle1 " attack        slash    " (Attack ["slash"]);  

  parse_test "test a forfeit input" 
    easy_battle1 "forfeit" Forfeit;  

  parse_test "test a forfeit input with spaces" 
    easy_battle1 "     forfeit  " Forfeit; 

  "test empty input" >::
  (fun _ -> assert_raises (EmptyCommand) 
      (fun () -> parse easy_battle1 "")); 

  "test empty command with spaces" >::
  (fun _ -> assert_raises (EmptyCommand) 
      (fun () -> parse easy_battle1 "   "));

  "test an attack of a defined fire move not in the moveset" >::
  (fun _ -> assert_raises (Invalid_Move)
      (fun () -> parse easy_battle1 "attack lava_plume")); 

  "test an attack of a defined normal move not in the moveset" >::
  (fun _ -> assert_raises (Invalid_Move)
      (fun () -> parse easy_battle1 "attack cut")); 

  "test an attack of an element that doesn't belong to this pokemon- water" >:: 
  (fun _ -> assert_raises (Invalid_Move)
      (fun () -> parse easy_battle1 "attack water_gun")); 

  "test an attack of an element that doesn't belong to this pokemon- grass" >:: 
  (fun _ -> assert_raises (Invalid_Move)
      (fun () -> parse easy_battle1 "attack leaf_blade")); 

  "test an input where the word after 'attack' is not a defined move" >::
  (fun _ -> assert_raises (Invalid_Move)
      (fun () -> parse easy_battle1 "attack white lightning"))
  ;                              

  "test a forfeit input that is followed by another word" >:: 
  (fun _ -> assert_raises (Invalid_Command)
      (fun () -> parse easy_battle1 "forfeit now")); 

  "test a forfeit input that is followed by a defined move" >:: 
  (fun _ -> assert_raises (Invalid_Command) 
      (fun () -> parse easy_battle1 "forfeit water_gun")); 

  "test a forfeit input that does not have appropriate letter casing" >:: 
  (fun _ ->  assert_raises (Invalid_Command) 
      (fun () -> parse easy_battle1 "Forfeit"));  

  "test an input where the first word is not 'attack' nor 'forfeit'" >:: 
  (fun _ ->  assert_raises (Invalid_Command) 
      (fun () -> parse easy_battle1 "do blast_burn")); 

  "test an input where the first word is not 'attack' nor 'forfeit' \
   and no move follows" >:: 
  (fun _ ->  assert_raises (Invalid_Command) 
      (fun () -> parse easy_battle1 "go")); 

  "test an attack input where nothing comes after the word 'attack'" >:: 
  (fun _ ->  assert_raises (EmptyMove) 
      (fun () -> parse easy_battle1 "attack"));     

  "test an attack input where spaces come after the word 'attack'" >:: 
  (fun _ ->  assert_raises (EmptyMove) 
      (fun () -> parse easy_battle1 "attack     "));  
]

let potionA = {
  potionname = "micro_potion";
  recovery = 0.5
}

let potionB =  {
  potionname = "mini_potion";
  recovery = 1.
}

let potionC =  {
  potionname = "potion";
  recovery = 2.5;
}

let boostA = {
  boostname = "vigor";
  multiplier = 1.2;
}
let boostB = {
  boostname = "enrage";
  multiplier = 1.5;
}

let poisonA = {
  poisonname = "toxins";
  damage = 0.5;
}

let poisonB =  {
  poisonname = "acid";
  damage = 0.3;
}

let item_battle = {
  p1_pkmn_alive = p1_pokemon; 
  p1_pkmn_in_battle = p1_pokemon |> List.hd;   
  p1_current_health = 5.0; 
  p1_current_moveset = [flamethrower; flare_blitz; slash; flash];
  p1_items = [
    Potion potionA; Potion potionB; Potion potionC; Poison poisonA;
    Poison poisonB; Boost boostA; Boost boostB
  ];
  p1_boost_mult = 1.;

  p2_pkmn_alive = p2_pokemon; 
  p2_pkmn_in_battle = p2_pokemon |> List.hd;  
  p2_current_health = 5.0; 
  p2_current_moveset = [leaf_storm; seed_bomb; headbutt; foresight]; 

  opponent_difficulty = Easy;
}

let string_of_use cmd = match cmd with 
  | Use item -> begin
      match item with 
      | Potion p -> p.potionname
      | Poison ps -> ps.poisonname
      | Boost b -> b.boostname
    end
  | Use _ -> failwith "not for this purpose"

let use_test 
    (name : string)
    (batt : Battle.battle)
    (str : string)
    (expected_output : command) : test =
  name >:: (fun _ -> 
      assert_equal expected_output (parse batt str) ~printer: string_of_use) 

let use_tests = [
  use_test
    "can parse potionA" 
    item_battle 
    "use potion micro_potion" 
    (Use (Potion (potionA)));

  use_test
    "can parse potionA with weird spacing" 
    item_battle 
    "use                                   potion        micro_potion" 
    (Use (Potion (potionA)));

  use_test
    "can parse potionB"
    item_battle 
    "use potion mini_potion"
    (Use (Potion (potionB)));

  use_test
    "can parse potionC"
    item_battle 
    "use potion potion"
    (Use (Potion (potionC)));

  use_test
    "can parse poisonA"
    item_battle 
    "use poison toxins"
    (Use (Poison (poisonA)));

  use_test
    "can parse poisonB"
    item_battle 
    "use poison acid"
    (Use (Poison (poisonB)));

  use_test
    "can parse poisonB with weird spacing"
    item_battle 
    "use     poison    acid                                               "
    (Use (Poison (poisonB)));

  use_test
    "can parse boostA"
    item_battle 
    "use boost vigor"
    (Use (Boost (boostA)));

  use_test
    "can parse boostA with weird spacing"
    item_battle 
    "use              boost                vigor"
    (Use (Boost (boostA)));

  use_test
    "can parse boostB"
    item_battle
    "use boost enrage"
    (Use (Boost (boostB)));

  use_test
    "can parse boostB with weird spacin"
    item_battle
    "use               boost                               enrage"
    (Use (Boost (boostB)));

]

let use_exception_test 
    (name : string)
    (batt : Battle.battle)
    (str : string)
    (expected_output : exn) : test =
  name >:: (fun _z -> 
      assert_raises expected_output (fun _ -> parse batt str)) 

let use_exception_tests = [
  use_exception_test
    "Invalid Boost"
    item_battle 
    "use boost toxins"
    Invalid_Boost;

  use_exception_test
    "Invalid Potion"
    item_battle 
    "use potion toxins"
    Invalid_Potion;

  use_exception_test
    "Invalid Poison"
    item_battle 
    "use poison vigor"
    Invalid_Poison;

  use_exception_test
    "Invalid Item 1"
    item_battle "use slash"
    Invalid_Item;

  use_exception_test
    "Invalid Item 2"
    item_battle "use attack slash"
    Invalid_Item;

  use_exception_test
    "Invalid Item 3"
    item_battle "use attack slash  asifnaoifnoa "
    Invalid_Item;
]

let suite = "The whole suite" >::: List.flatten [
    battle_tests;
    command_tests; 
    use_tests;
    use_exception_tests;
  ]

let _ = run_test_tt_main suite