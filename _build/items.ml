

type potion = {
  potionname : string;
  recovery : float;
}

type boost = {
  boostname : string;
  multiplier : float;
}

type poison = {
  poisonname : string;
  damage : float;
}

type item = 
  | Potion of potion
  | Boost of boost
  | Poison of poison

let poisons = [
  {
    poisonname = "toxin";
    damage = 1.;
  };
  {
    poisonname = "super_toxin";
    damage = 1.5;
  };
  {
    poisonname = "hyper_toxin";
    damage = 2.;
  };
  {
    poisonname = "max_toxin";
    damage = 3.;
  };
]

let boosts = [
  {
    boostname = "max_boost";
    multiplier = 2.;
  };
  {
    boostname = "hyper_boost";
    multiplier = 1.8;
  };
  {
    boostname = "super_boost";
    multiplier = 1.5;
  };
  {
    boostname = "quick_boost";
    multiplier = 1.3;
  };
]


let potions = [
  {
    potionname = "quick_potion";
    recovery = 1.
  };
  {
    potionname = "super_potion";
    recovery = 2.;
  };
  {
    potionname = "hyper_potion";
    recovery = 3.
  };
  {
    potionname = "max_potion";
    recovery = 4.
  };
]