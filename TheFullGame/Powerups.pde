ArrayList<Powerup> powerups = new ArrayList<>();

int lastPowerupTime = 0;
int powerupInterval = 5000;

float speed = 25;
PImage doubleBulletPowerup;    
PImage speedPowerup;           
PImage firePowerup;          
PImage fireballImage;

boolean doubleBulletPowerupActive = false;
boolean speedPowerUpActive = false;
boolean fireBallPowerupActive = false;
 boolean noActivePowerups = true;

void dropPowerup() 
{
    for (int i = 0; i < powerups.size(); i++) 
    {
      Powerup powerup = powerups.get(i);
      if (powerup.isPowerupActive()) 
      {
          noActivePowerups = false;
          break;
      }
    }
 
    if (noActivePowerups == true)
    {
      // int randomAlienIndex = int(random(aliens.length-1));
       int randomAlienIndex = int(random(3, 6));
       Alien randomAlien = aliens[randomAlienIndex];
       Alien randomAlien2 = aliens[randomAlienIndex+1];
       
       float randomX = (randomAlien.x + randomAlien2.x)/2;
       float randomY = randomAlien.y + alienHeight;
       int randomPowerupType = (int) random(1, 4);
       powerups.add(new Powerup(randomX, randomY, randomPowerupType));   
    }
     
    if (noActivePowerups == true) 
    {
       ArrayList<Alien> validAliens = new ArrayList<>(); // Create a list to store valid aliens
       for (int i = 0; i < aliens.length; i++) 
       {
          Alien validAlien= aliens[i];
          if (!validAlien.exploding && !validAlien.exploded) 
          {
            validAliens.add(validAlien);
          }
        }
        
        // If there are valid aliens, select a random one and drop the powerup from underneath it
        if (validAliens.isEmpty() == false) 
        {
            int randomAlienIndex = (int) random(validAliens.size());
            Alien randomAlien = validAliens.get(randomAlienIndex);
            
            float randomX = randomAlien.x;
            float randomY = randomAlien.y + alienHeight;
            
            int randomPowerupType = (int) random(1, 4); // Generates random number between 1 and 3
            powerups.add(new Powerup(randomX, randomY, randomPowerupType));
        }
    }
    
}


void applyPowerupEffect(int powerupType) 
{
    switch (powerupType) 
    {
        case 1: // Double bullets powerup
            doubleBulletPowerupActive = true;
            speedPowerUpActive = false;
            fireBallPowerupActive = false;
            break;
        case 2: // Speed powerup
            speedPowerUpActive = true;
            doubleBulletPowerupActive = false;
            fireBallPowerupActive = false;
            break;
        case 3: // Fire powerup
            fireBallPowerupActive = true;
            doubleBulletPowerupActive = false;
            speedPowerUpActive = false;
            break;
        default:
            break;
    }
}

class Powerup 
{
    long activationTime;
    float x;
    float y;
    int type;
    float speed;

    Powerup(float x, float y, int type) 
    {
        this.x = x;
        this.y = y;
        this.type = type;
        this.speed = 4;
    }

    void draw() 
    {
      if (!isPowerupActive()) 
      {
        PImage powerupImage;
         
        switch (type) 
        {
            case 1: // Double bullet powerup
                powerupImage = doubleBulletPowerup;
                break;
            case 2: // Speed powerup
                powerupImage = speedPowerup;
                break;
            case 3: // Fire powerup
                powerupImage = firePowerup;
                break;
            default:
                return; // Exit the function if the powerup type is invalid
         }
        
        image(powerupImage, x, y, 35, 35);

        if (collidesWithPlayer(theHumanPlayer)) 
        {
            applyPowerupEffect(theHumanPlayer);
            powerups.remove(this);
        }
      }
    }
    
    boolean isPowerupActive(boolean powerUpThatsActive) 
    {
     if (powerUpThatsActive == true)
     {
      long powerUpLengthLimit= 2000;
      long powerUpLength = millis() - activationTime ;
      
      if (powerUpLength >= powerUpLengthLimit)
        return false; 
      else
        return true;
     }
     return false;
    }
    
    boolean isPowerupActive() 
    {
      long powerUpLengthLimit= 2000;
      long powerUpLength = millis() - activationTime ;
      
      if (powerUpLength >= powerUpLengthLimit)
        return false; 
      else
        return true;
    }

    void updateMovement() 
    {
        y += speed;
        if (y > SCREENY) 
        {
            powerups.remove(this);
        }
    }

    int getType() 
    {
        return type;
    }

   void checkCollisionWithPlayer(Player player) 
   {
      if (x == theHumanPlayer.xpos +30 && y == 380) 
      {
         applyPowerupEffect(player);
         powerups.remove(this);
        }
    }
    
    void applyPowerupEffect(Player player) 
    {
      switch (type) 
      {
          case 1: // Double bullet powerup
              doubleBulletPowerupActive = true;
              isPowerupActive(doubleBulletPowerupActive); 
              break;
          case 2: // Speed powerup
              speedPowerUpActive = true;
              isPowerupActive(speedPowerUpActive); 
              break;
          case 3: // Fire powerup
              fireBallPowerupActive = true;
              isPowerupActive(fireBallPowerupActive); 
              break;
          default:
              break;
      }
    }
    
    boolean collidesWithPlayer(Player player) 
    {
        float centerX = x + 30; 
        float centerY = y + 30; 
        
        // Check if the center of the powerup is inside the player's paddle rectangle
        if (centerX >= player.xpos && centerX <= player.xpos + PADDLEWIDTH &&
            centerY >= player.ypos && centerY <= player.ypos + PADDLEHEIGHT)
        {
            return true; // Collision detected
        }
        
        return false; 
    }
}
