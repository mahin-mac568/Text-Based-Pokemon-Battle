# Text Based Pokemon Battle

## Quickstart Guide
### 1. Cloning the repository from Git
```bash
git clone https://github.com/mahin-mac568/Text-Based-Pokemon-Battle.git
cd Text-Based-Pokemon-Battle
```
### 2. Running the game 
```
make play
```
### 3. Read the instructions and play the game. 
### Come back here for further details on in-game objects. 
<p><br></p>
<p><br></p>

### These are the instructions displayed in the game: 
    
<p>The game you are about to play consists of 3 battles. Try your best to be the very best pokemon trainer!<br>
    <br> 
   Here's some things you should know: Each battle is harder than the last. The first battle is the easiest. Your opponent's health per pokemin is lower, and the CPU uses random attacks. The second battle gives your opponent more health per pokemon, increasing your chances of losing. The third battle features a CPU that always chooses the move that does the most damage to your pokemon. This will be your biggest challenge. <br>
    <br> 
   In this game, you can either attack or use items. You can repeat attacks as much as you like. <br> 
    <br> 
   You can use items, but they expire after use. You will get three items at the beginning of each battle: one poison, one potion, and one boost.
    <br> </p>
    
#### To use an available attack, 
- Type ```attack [attack name here]```

#### You can also use items! Items are in the order of [potion, poison, boost].
- To use a potion to heal, type ```use potion [potion name here]```
- To use a poison against your opponent, type ```use poison [poison name here]```
- To use a boost, type ```use boost [boost name here]```

#### Lastly, you can quit by typing ```forfeit```, but we don't like quitters.

#### That's all. Good luck!"
<p><br></p>

### Here's some more info on the items: 

#### Potions:
- quick_potion: recovers ```1``` health point for your current pokemon. 
- super_potion: recovers ```2``` health points for your current pokemon. 
- hyper_potion: recovers ```3``` health points for your current pokemon. 
- max_potion: recovers ```4``` health points for your current pokemon. 

#### Poisons:
- toxin: deals ```1``` damage point against the opponent's current pokemon. 
- super_toxin: deals ```1.5``` damage points against the opponent's current pokemon.
- hyper_toxin: deals ```2``` damage points against the opponent's current pokemon.
- max_toxin: deals ```3``` damage points against the opponent's current pokemon. 

#### Boosts:
- quick_boost: gives you a ```1.3x``` boost on the damage that your moves deal on the current opposing pokemon. 
- super_boost: gives you a ```1.5x``` boost on the damage that your moves deal on the current opposing pokemon. 
- hyper_boost: gives you a ```1.8x``` boost on the damage that your moves deal on the current opposing pokemon. 
- max_boost: gives you a ```2x``` boost on the damage that your moves deal on the current opposing pokemon. 
