(** Represents potions *)
type potion = {
  potionname : string;
  recovery : float;
}

(** Represents boosts *)
type boost = {
  boostname : string;
  multiplier : float;
}

(** Represents poisons *)
type poison = {
  poisonname : string;
  damage : float;
}

(** Ecapsulates potions, poisons, and boosts *)
type item = 
  | Potion of potion
  | Boost of boost
  | Poison of poison

(** List of all available poisons*)
val poisons : poison list

(** List of all available potions*)
val potions : potion list

(** List of all available boosts*)
val boosts : boost list