open Pkmn 
open Pokemon
open Battle 
open Items

(** This file processes the move commands that will be typed by 
    the user *)

type command = 
  | Attack of string list 
  | Use of item
  | Forfeit 

exception EmptyCommand 

exception EmptyMove 

exception EmptyUse

exception Invalid_Command

exception Invalid_Move

exception Invalid_Item

exception Invalid_Potion

exception Invalid_Poison

exception Invalid_Boost

let find_poison name = 
  match List.find_opt (fun e -> name = e.poisonname) poisons with
    | Some poison -> Poison poison
    | None -> raise Invalid_Poison

let find_potion name = 
  match List.find_opt (fun e -> name = e.potionname) potions with
    | Some potion -> Potion potion
    | None -> raise Invalid_Potion

let find_boost name = 
  match List.find_opt (fun e -> name = e.boostname) boosts with
    | Some boost -> Boost boost
    | None -> raise Invalid_Boost

let lst_of_command str = 
  let str_lst = String.split_on_char ' ' str in 
  List.filter (fun x -> x <> "") str_lst 

let process_lst (curr_mvs : Battle.battle) lst = 
  match lst with 
  | [] -> raise (EmptyCommand)
  | h :: [] -> begin 
      if h = "attack" then raise (EmptyMove) 
      else if h = "forfeit" then Forfeit 
      else if h = "use" then raise (EmptyUse)
      else raise (Invalid_Command)
    end 
  | h :: t when h = "use" -> begin
    if List.length t <> 2 then raise Invalid_Item
    else match t with 
      | [t;name] when t = "poison" -> Use (find_poison name)
      | [t;name] when t = "potion" ->  Use (find_potion name)
      | [t;name] when t = "boost" -> Use (find_boost name)
      | _ -> raise Invalid_Item
  end
  | h :: t -> begin 
      let valid_length = (List.length t = 1) in 
      let move = List.hd t in 
      if h = "attack" && (acceptable_attack curr_mvs move) 
         && valid_length then Attack t 
      else if h <> "attack" then raise Invalid_Command  
      else raise Invalid_Move
    end 



let parse (curr_mvs : Battle.battle) str = 
  let lst_form = lst_of_command str in 
  process_lst curr_mvs lst_form 






