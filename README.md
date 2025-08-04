# alien-shooting-game

A Space Invaders-style arcade game built in Processing with aliens, shields, power-ups, and bombs.
Building on from the alien game from Programming Project module 

## 📖 About

This is a classic Space Invaders implementation built in Processing. The player controls a paddle at the bottom of the screen and must destroy waves of alien invaders while avoiding their attacks. The game features destructible shields, various power-ups, and enemy bombs.

## 🎮 Game Features

- **Player Movement** - Control paddle with mouse or arrow keys
- **Alien Invaders** - Grid of aliens that move horizontally and drop down
- **Shooting System** - Fire bullets to destroy aliens
- **Destructible Shields** - Two shields that can be damaged by bullets and bombs
- **Power-up System** - Three types of power-ups with special effects
- **Enemy Bombs** - Aliens drop bombs that can destroy shields and kill the player
- **Explosion Effects** - Visual feedback when aliens are destroyed

## 📁 File Structure
├── TheFullGame.pde          # Main game file with setup() and draw()
├── Player.pde               # Player paddle class
├── Alien.pde                # Alien enemy class
├── Bullet.pde               # Bullet projectile system
├── Shield.pde               # Destructible shield system
├── Powerups.pde             # Power-up system and effects
├── Bomb.pde                 # Enemy bomb system
└── Data/                    # Required image files (see setup)
    ├── exploding.GIF
    ├── invader - white.GIF
    ├── double bullet - powerup.png
    ├── speed - powerup.png
    ├── bomb - powerup.png
    ├── fire - powerup.png
    └── Bomb - new.png


## 🚀 Setup Instructions

### Prerequisites
- **Processing 3.0+** - Download from [processing.org](https://processing.org/download/)

### Installation

1. **Download the game files**
   - Download all .pde files to a folder named "TheFullGame"

2. **Create required image files**
   The game requires these specific image files in the exact paths:
   
   **Required Images:**
   - `exploding.GIF` - Explosion animation
   - `invader - white.GIF` - Alien sprite
   - `double bullet - powerup.png` - Double bullet power-up icon
   - `speed - powerup.png` - Speed boost power-up icon
   - `bomb - powerup.png` - Bomb power-up icon (also in Week 5/Data/)
   - `fire - powerup.png` - Fire power-up icon
   - `Bomb - new.png` - Enemy bomb sprite

3. **Update file paths**
   - Open each .pde file
   - Update the hard-coded file paths to match your system
   - Change all instances of `"C:/Users/nanda/Desktop/..."` to your actual file paths

4. **Run the game**
   - Open `TheFullGame.pde` in Processing
   - Click the Run button

## 🎮 How to Play

### Controls
- **Mouse Movement** - Move player paddle left and right
- **Mouse Click** - Fire bullets (with cooldown)
- **Spacebar** - Alternative shooting method

### Gameplay
- **Objective** - Destroy all aliens to win
- **Movement** - Aliens move side to side and drop down when hitting edges
- **Shields** - Two destructible shields provide cover
- **Lives** - Game ends when player is hit by bomb or alien reaches bottom
- **Power-ups** - Collect falling power-ups for special abilities

### Power-up Types
1. **Double Bullet** (Purple) - Fire two bullets simultaneously
2. **Speed Boost** (Yellow) - Faster bullet speed
3. **Fire/Bomb** (Orange) - Enhanced bullet effects
