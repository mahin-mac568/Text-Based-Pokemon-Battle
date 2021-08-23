
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
    ("sacred_fire", Fire); ("searing_hot", Fire); ("shell_trap", Fire);
    ("sizzly_slide", Fire); ("sunny_day", Fire); ("v-create", Fire); 
    (** NORMAL TYPE*)
    ("body_slam", Normal); ("boomburst", Normal); ("breakneck_blitz", Normal); 
    ("chip_away", Normal); ("comet_punch", Normal); ("confide", Normal); 
    ("constrict", Normal); ("crush_claw", Normal); ("crush_grip", Normal); 
    ("cut", Normal); ("disable", Normal); ("dizzy_punch", Normal); 
    ("double_hit", Normal); ("double_slap", Normal); ("double_team", Normal); 
    ("double_edge", Normal); ("echoed_voice", Normal); ("egg_bomb", Normal);
    ("explosion", Normal); ("extreme_evoboost", Normal);
    ("extreme_speed	",Normal); ("facade", Normal); ("barrage", Normal); 
    ("fake_out", Normal); ("false_swipe", Normal); ("fury_attack", Normal); 
    ("fury_swipes", Normal); ("giga_impact", Normal); ("guillotine", Normal); 
    ("happy_hour", Normal); ("head_charge", Normal); ("headbutt", Normal); 
    ("hidden_power", Normal); ("hold_back", Normal);  ("horn_attack", Normal); 
    ("horn_drill", Normal); ("howl", Normal); ("hyper_beam", Normal);
    ("hyper_fang", Normal); ("hyper_voice", Normal); ("judgment", Normal);  
    ("last_resort", Normal); ("max_guard", Normal); ("max_strike", Normal); 
    ("mega_kick", Normal); ("mega_punch", Normal); ("morning_sun", Normal); 
    ("natural_gift", Normal); ("nature_power", Normal); ("noble_roar", Normal)
    ; 
    ("odor_sleuth", Normal); ("pain_split", Normal); ("pay_day", Normal); 
    ("perish_song", Normal); ("play_nice", Normal); ("pound", Normal); 
    ("present", Normal);  ("pulverizing", Normal); ("quick_attack", Normal); 
    ("rage", Normal); ("rapid_spin", Normal); ("razor_wind", Normal); 
    ("retaliate	", Normal); ("return", Normal); ("revelation_dance", Normal); 
    ("roar", Normal); ("rock_climb", Normal); ("round", Normal); 
    ("scary_face", Normal); ("scratch", Normal); ("secret_power", Normal); 
    ("sharpen", Normal); ("shell_smash", Normal); ("simple_beam", Normal); 
    ("sing", Normal); ("sketch", Normal); ("skull_bash", Normal); 
    ("slam", Normal); ("slash", Normal); ("sleep_talk", Normal); 
    ("sonic_boom", Normal); ("spike_cannon", Normal); ("spit_up", Normal); 
    ("stomp", Normal); ("strength", Normal); ("struggle", Normal); 
    ("super_fang", Normal); ("supersonic", Normal); ("swift", Normal); 
    ("swords_dance", Normal); ("tackle", Normal); ("tail_slap", Normal); 
    ("take_down", Normal); ("teatime", Normal); ("techno_blast", Normal); 
    ("teeter_dance", Normal); ("terrain_pulse", Normal); ("thrash", Normal); 
    ("tickle", Normal); ("transform", Normal); ("tri_attack", Normal); 
    ("trump_card", Normal); ("uproar", Normal); ("veevee_volley", Normal); 
    ("vise_grip", Normal); ("whirlwind", Normal); ("wrap", Normal); 
    ("endeavor", Normal);
    (** WATER TYPE*)
    ("aqua_jet", Water);("aqua_ring", Water); ("aqua_tail", Water); 
    ("bouncy_bubble", Water); ("bubble", Water); ("brine", Water); 
    ("bubble_beam", Water); ("clamp", Water); ("crabhammer", Water); 
    ("dive", Water); ("fishious_rend", Water); ("flip_turn", Water); 
    ("hydro_cannon", Water); ("hydro_pump", Water); ("hydro_vortex", Water);  
    ("liquidation", Water); ("max_geyser", Water); ("muddy_water", Water); 
    ("oceanic_operetta", Water); ("octazooka", Water); ("origin_pulse", Water); 
    ("rain_dance", Water); ("razor_shell", Water); ("scald", Water); 
    ("snipe_shot", Water);  ("soak", Water); ("sparkling_aria", Water); 
    ("splishy_splash", Water); ("steam_eruption", Water); ("surf", Water); 
    ("surging_strikes", Water);  ("water_gun", Water);  ("water_pledge", Water);
    ("water_pulse", Water);  ("water_shuriken", Water); ("water_sport", Water); 
    ("water_spout", Water); ("waterfall", Water); 
    ("whirlpool", Water); ("withdraw", Water); 
    (** GRASS TYPE*)
    ("absorb", Grass);("apple_acid", Grass); ("aromatherapy", Grass); 
    ("bloom_doom", Grass); ("branch_poke", Grass); ("bullet_seed", Grass); 
    ("cotton_spore", Grass); ("drum_beating", Grass); ("energy_ball", Grass); 
    ("forest's_curse", Grass); ("frenzy_plant", Grass); ("giga_drain", Grass); 
    ("grass_knot", Grass); ("grass_pledge", Grass); ("grass_whistle", Grass); 
    ("grassy_glide", Grass); ("grassy_terrain", Grass); ("grav_apple", Grass); 
    ("horn_leech", Grass); ("ingrain", Grass); ("jungle_healing", Grass); 
    ("leaf_blade", Grass); ("leaf_storm", Grass); ("leaf_tornado", Grass); 
    ("leafage", Grass); ("leech_seed", Grass); ("magical_leaf", Grass); 
    ("max_overgrowth", Grass); ("mega_drain", Grass); ("needle_arm", Grass); 
    ("petal_blizzard", Grass); ("petal_dance", Grass); ("power_whip", Grass); 
    ("razor_leaf", Grass); ("sappy_seed", Grass); ("seed_bomb", Grass); 
    ("seed_flare", Grass); ("sleep_powder", Grass); ("snap_trap", Grass); 
    ("solar_beam", Grass); ("solar_blade", Grass); ("spiky_shield", Grass); 
    ("spore", Grass); ("strength_sap", Grass); ("stun_spore", Grass); 
    ("synthesis", Grass); ("trop_kick", Grass); ("vine_whip", Grass); 
    ("wood_hammer", Grass);("worry_seed", Grass);

    (** the rest operate as regular moves until we add functionality *)

    (** Useless moves that "waste" a turn *)
    ("splash", Normal); ("flail", Normal); 

    (** moves with unique affects *)
    ("substitute", Normal); ("protect", Normal); ("feint", Normal); 
    ("encore", Normal); ("endure", Normal); ("conversion", Normal); 
    ("copycat", Normal); ("court_change", Normal); ("block", Normal);  
    ("after_you", Normal); ("baton_pass", Normal); 

    (** moves that place status effects on targeted pokemon *)
    ("yawn", Normal);("smelling_salts", Normal); ("relic_song", Normal);

    (** moves that place status effects on own pokemon *)
    ("snore", Normal); 

    (** moves that affect stats of target pokemon *)
    ("wring_out", Normal);("tearful_look", Normal);("sweet_scent", Normal); 
    ("tail_whip", Normal); ("swagger", Normal); ("spotlight", Normal);
    ("smokescreen", Normal); ("mean_look", Normal);("metronome", Normal); 
    ("leer", Normal); ("lovely_kiss", Normal); ("hold_hands", Normal); 
    ("bind", Normal);  ("entrainment", Normal); ("flash", Normal); 
    ("follow_me", Normal); ("glare", Normal); ("growl", Normal); 
    ("attract", Normal); 

    (** moves that affect stats of own pokemon *)
    ("cotton_guard", Grass); ("work_up", Normal); ("swallow", Normal);
    ("stuff_cheeks", Normal); ("stockpile", Normal); ("soft-boiled", Normal); 
    ("slack_off", Normal); ("safeguard", Normal); ("psych_up", Normal);
    ("recycle", Normal); ("reflect_type", Normal); ("refresh", Normal);
    ("mimic", Normal); ("mind_reader", Normal); ("minimize", Normal); 
    ("growth", Normal);  ("harden", Normal);("lucky_chant", Normal); 
    ("max_guard", Normal); ("me_first", Normal);("laser_focus", Normal); 
    ("acupressure", Normal); ("belly_drum", Normal); ("bestow", Normal); 
    ("bide", Normal);  ("acupressure", Normal); ("after_you", Normal);
    ("covet", Normal);  ("defense_curl", Normal);("focus_energy", Normal); 
    ("foresight", Normal); ("frustration", Normal);("camouflage", Normal); 
    ("captivate", Normal);

    (** moves that heal own pokemon  *)
    ("life_dew", Water); ("wish", Normal); ("recover", Normal); 
    ("milk_drink", Normal); ("heal_bell", Normal); 

    (** moves that heal targeted pokemon *)
    ("helping_hand", Normal); ("assist", Normal); 
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