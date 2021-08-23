(** Creates pokemon and handles their attributes and stats *)
module type PokemonSig = sig

  (** [element] represents the element to which a pokemon belongs; can be 
      Fire, Water, Grass, or Normal *)
  type element = 
    | Fire 
    | Water 
    | Grass 
    | Normal 

  (** [move] represents an individual move. Each move has a name field and 
      an element field. *)
  type move = {
    name : string; 
    element : element;
  }

  (** [pkmn] represents an individual pokemon. Each pokemon has a name and 
      an element. *)
  type pkmn = {
    name : string; 
    elemental : element; 
  }


  
  (** List of all pokemon and list of all moves. Each element is of type 
      pkmn and type element, respectively *)
  val list_of_moves : move list
  val list_of_pkmn : pkmn list

  (** List of all moves within a specific element category. Can be fire, water, 
      grass or normal moves. *)
  val fire_mvs : move list
  val water_mvs : move list
  val grass_mvs : move list
  val norm_mvs : move list

  (** List of all pokemon within a specific element category. Can be fire, 
      water or grass pokemon. *)
  val fire_pkmn : pkmn list
  val water_pkmn : pkmn list
  val grass_pkmn : pkmn list

end

module Pokemon : PokemonSig