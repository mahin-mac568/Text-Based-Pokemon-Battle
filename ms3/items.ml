

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
    poisonname = "toxins";
    damage = 0.5;
  };
  {
    poisonname = "acid";
    damage = 0.3;
  };
  {
    poisonname = "radiation";
    damage = 0.7;
  };
  {
    poisonname = "lead";
    damage = 0.6;
  };
  {
    poisonname = "stress";
    damage = 0.2;
  };
  {
    poisonname = "covid";
    damage = 1.2;
  };
  {
    poisonname = "cyanide";
    damage = 0.4;
  };
  {
    poisonname = "bleach";
    damage = 1.3;
  }
]

let boosts = [
  {
    boostname = "vigor";
    multiplier = 1.2;
  };
  {
    boostname = "enrage";
    multiplier = 1.5;
  };
  {
    boostname = "strengthen";
    multiplier = 1.8;
  };
  {
    boostname = "full_power";
    multiplier = 2.;
  };
  {
    boostname = "blue_pill";
    multiplier = 1.3;
  };
  {
    boostname = "red_bull";
    multiplier = 0.9;
  };
  {
    boostname = "caffiene";
    multiplier = 1.1;
  };
]


let potions = [
  {
    potionname = "micro_potion";
    recovery = 0.5
  };
  {
    potionname = "mini_potion";
    recovery = 1.
  };
  {
    potionname = "potion";
    recovery = 2.5;
  };
  {
    potionname = "mega_potion";
    recovery = 3.
  };
  {
    potionname = "giga_potion";
    recovery = 4.
  };
  {
    potionname = "full_restore";
    recovery = 10.;
  };
  {
    potionname = "good_sleep";
    recovery = 3.;
  };
  {
    potionname = "advil";
    recovery = 2.;
  };
  {
    potionname = "mucinex";
    recovery = 3.5;
  };
  {
    potionname = "nyquil";
    recovery = 6.;
  };
  {
    potionname = "party";
    recovery = 0.5;
  }
]