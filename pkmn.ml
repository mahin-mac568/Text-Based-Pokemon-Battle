
module type PokemonSig = sig 
  type element = 
    | Fire 
    | Water 
    | Grass 
    | Normal 

  type move = {
    name : string; 
    element : element;
  }

  type pkmn = {
    name : string; 
    elemental : element; 
  }

  val list_of_moves : move list
  val list_of_pkmn : pkmn list
  val fire_mvs : move list
  val water_mvs : move list
  val grass_mvs : move list
  val norm_mvs : move list
  val fire_pkmn : pkmn list
  val water_pkmn : pkmn list
  val grass_pkmn : pkmn list
end

module Pokemon : PokemonSig = struct 

  type element = 
    | Fire 
    | Water 
    | Grass 
    | Normal 

  type move = {
    name : string; 
    element : element;
  }

  type pkmn = {
    name : string; 
    elemental : element; 
  }


  let moves_tup_lst = [
    (** FIRE TYPE *)
    ("flamethrower", Fire); ("flare_blitz", Fire); ("heat_wave", Fire);
    ("lava_plume", Fire);("fire_blast", Fire); ("sacred_fire", Fire); 
    ("blast_burn", Fire);("blaze_kick", Fire); ("blue_flare", Fire); 
    ("burn_up", Fire); ("burning jealousy", Fire); ("ember", Fire); 
    ("fiery_dance", Fire); ("fire_fang", Fire); ("fire_lash", Fire);
    ("fire_ledge", Fire); ("fire_punch", Fire); ("fire_spin", Fire); 
    ("flame_burst", Fire); ("flame_charge", Fire); ("flame_wheel", Fire); 
    ("fusion_flare", Fire); ("heat_crash", Fire); ("heat_wave", Fire); 
    ("incinerate", Fire); ("inferno", Fire); ("inferno_overdrive", Fire); 
    ("lava_plume", Fire); ("magma_storm", Fire); ("max_flare", Fire); 
    ("mind_blown", Fire); ("mystical_fire", Fire); ("pyro_ball", Fire); 
    ("sacred_fire", Fire); ("searing_hot", Fire); ("sizzly_slide", Fire); 
    (** NORMAL TYPE*)
    ("body_slam", Normal); ("boomburst", Normal); ("breakneck_blitz", Normal); 
    ("chip_away", Normal); ("comet_punch", Normal); ("crush_claw", Normal); 
    ("cut", Normal); ("dizzy_punch", Normal); ("double_hit", Normal); 
    ("double_slap", Normal); ("double_edge", Normal); ("crush_grip", Normal); 
    ("extreme_speed	",Normal); ("facade", Normal); ("barrage", Normal); 
    ("fake_out", Normal); ("false_swipe", Normal); ("fury_attack", Normal); 
    ("fury_swipes", Normal); ("giga_impact", Normal); ("guillotine", Normal); 
    ("head_charge", Normal); ("headbutt", Normal); ("horn_attack", Normal); 
    ("max_strike", Normal); ("mega_kick", Normal); ("mega_punch", Normal); 
    ("hyper_beam", Normal); ("pound", Normal); ("quick_attack", Normal); 
    ("retaliate", Normal); ("scratch", Normal); ("simple_beam", Normal); 
    ("skull_bash", Normal); ("slam", Normal); ("slash", Normal);
    ("stomp", Normal); ("strength", Normal); ("super_fang", Normal); 
    ("tackle", Normal); ("take_down", Normal); ("thrash", Normal);
    ("hyper_fang", Normal); ("hyper_voice", Normal); 
    (** WATER TYPE*)
    ("aqua_jet", Water); ("aqua_tail", Water); ("bubble", Water); 
    ("brine", Water); ("bubble_beam", Water); ("crabhammer", Water); 
    ("hydro_cannon", Water); ("hydro_pump", Water); ("hydro_vortex", Water);  
    ("liquidation", Water); ("max_geyser", Water); ("muddy_water", Water); 
    ("oceanic_operetta", Water); ("octazooka", Water);
    ("razor_shell", Water); ("scald", Water); 
    ("steam_eruption", Water); ("surf", Water); ("water_gun", Water);  
    ("water_pledge", Water); ("water_pulse", Water); ("water_shuriken", Water);
    ("water_spout", Water); ("waterfall", Water); ("whirlpool", Water);
    ("dive", Water); ("fishious_rend", Water); 
    (** GRASS TYPE*)
    ("absorb", Grass); ("bloom_doom", Grass); ("branch_poke", Grass); 
    ("forest's_curse", Grass); ("frenzy_plant", Grass); ("giga_drain", Grass); 
    ("grass_knot", Grass); ("grass_pledge", Grass); ("grass_whistle", Grass); 
    ("grassy_glide", Grass); ("horn_leech", Grass); 
    ("leaf_blade", Grass); ("leaf_storm", Grass); ("leaf_tornado", Grass); 
    ("petal_blizzard", Grass); ("petal_dance", Grass); ("power_whip", Grass); 
    ("razor_leaf", Grass); ("sappy_seed", Grass); ("seed_bomb", Grass); 
    ("strength_sap", Grass); ("trop_kick", Grass); ("vine_whip", Grass); 
    ("wood_hammer", Grass);("worry_seed", Grass); ("bullet_seed", Grass);
    ("leech_seed", Grass); ("magical_leaf", Grass); ("seed_flare", Grass); 
    ("snap_trap", Grass); ("mega_drain", Grass); ("needle_arm", Grass); 
  ]

  let tuple_to_move tup = { 
    name = (fst tup); 
    element = (snd tup);
  }

  let list_of_moves = List.map tuple_to_move moves_tup_lst

  let pkmn_tup_lst = [
    ("charizard", Fire);
    ("charmeleon", Fire);
    ("charmander", Fire);
    ("cyndaquil", Fire);
    ("quilava", Fire);
    ("typhlosion", Fire);
    ("incineroar", Fire); 
    ("arcanine", Fire);
    ("blaziken", Fire); 
    ("moltres", Fire); 
    ("infernape", Fire);
    ("ninetales", Fire);
    ("entei", Fire); 
    ("typhlosion", Fire); 
    ("flareon", Fire); 
    ("empoleon", Water);
    ("totodile", Water); 
    ("croconaw", Water); 
    ("feraligatr", Water); 
    ("blastoise", Water);
    ("wartortle", Water);
    ("squirtle", Water); 
    ("gryados", Water);
    ("milotic", Water);
    ("vaporeon", Water); 
    ("lapras", Water); 
    ("sharpedo", Water);
    ("wailord", Water); 
    ("kingdra", Water); 
    ("suicune", Water); 
    ("sceptile", Grass); 
    ("torterra", Grass); 
    ("venusaur", Grass);
    ("ivysaur", Grass);
    ("chikorita", Grass);
    ("bayleef", Grass);
    ("meganium", Grass);
    ("bulbasaur", Grass); 
    ("leafeon", Grass);
    ("roserade", Grass);
    ("virizon", Grass); 
    ("tropius", Grass); 
    ("leavanny", Grass);
    ("kartana", Grass); 
    ("ferrothorn", Grass);
  ]

  let tuple_to_pkmn tup = { 
    name = (fst tup); 
    elemental = (snd tup);
  }

  let list_of_pkmn = List.map tuple_to_pkmn pkmn_tup_lst


  let fire_move_id mv = 
    if mv.element = Fire then true else false

  let fire_pkmn_id pkmn =
    if pkmn.elemental = Fire then true else false

  let water_move_id mv = 
    if mv.element = Water then true else false

  let water_pkmn_id pkmn =
    if pkmn.elemental = Water then true else false

  let grass_move_id mv = 
    if mv.element = Grass then true else false

  let grass_pkmn_id pkmn =
    if pkmn.elemental = Grass then true else false

  let norm_move_id mv = 
    if mv.element = Normal then true else false

  let norm_pkmn_id pkmn =
    if pkmn.elemental = Normal then true else false

  let fire_mvs = 
    List.filter fire_move_id list_of_moves

  let water_mvs = 
    List.filter water_move_id list_of_moves

  let grass_mvs = 
    List.filter grass_move_id list_of_moves

  let norm_mvs = 
    List.filter norm_move_id list_of_moves

  let fire_pkmn = 
    List.filter fire_pkmn_id list_of_pkmn

  let water_pkmn = 
    List.filter water_pkmn_id list_of_pkmn

  let grass_pkmn =
    List.filter grass_pkmn_id list_of_pkmn

end 