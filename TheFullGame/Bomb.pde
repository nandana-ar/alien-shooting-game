PImage bombImage;
final int BOMB_WIDTH = 50;
final int BOMB_HEIGHT = 50;

ArrayList<Bomb> bombs = new ArrayList<>();
int lastBombTime = 0;
int bombInterval = 8000;
boolean noActiveBombs = true;

class Bomb 
{
  float x;
  float y;
  float speed = 7;
  long activationTime;
  
  Bomb(float x, float y)
  {
    this.x = x;
    this.y = y;
    this.activationTime = millis();
  }
  
  void move()
  {
    y +=speed;
  }
  
  void draw()
  {
    bombImage = loadImage
   ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 5/Data/Bomb - new.png");
     image(bombImage, x, y,  BOMB_WIDTH, BOMB_HEIGHT); 
  }
  
  boolean offScreen()
  {
    if(y > SCREENY)
    return true;
    else
    return false;
  }
  
  boolean collide (Player player)
  {
    float bombRight = x + BOMB_WIDTH/1.25;
    float bombBottom = y + BOMB_HEIGHT/1.25;
    float playerRight = player.xpos + PADDLEWIDTH;
    float playerBottom = player.ypos + PADDLEHEIGHT;

    if (x < playerRight && bombRight > player.xpos && y < playerBottom && bombBottom > player.ypos) 
    {
       return true;  
    }
    
    return false; 
  } 
  

  
  boolean collide(Shield shield) 
  {
    float bombRight = x + BOMB_WIDTH / 1.25;
    float bombBottom = y + BOMB_HEIGHT / 1.25;
    float shieldRight = shield.x + (shield.rectWidth * shield.numRectangles);
    float shieldBottom = shield.y + shield.rectHeight;

    if (x < shieldRight && bombRight > shield.x && y < shieldBottom && bombBottom > shield.y) 
    {
        return true;
    }
    
    return false;
  }

  boolean isBombActive() 
  {
    long bombLengthLimit= 2000;
    long bombLength = millis() - activationTime ;
    
    if (bombLength >= bombLengthLimit)
      return false; 
    else
      return true;
  }
  
}

void dropBomb() 
{
  if (noActiveBombs) 
  {
    ArrayList<Alien> validAliens = new ArrayList<>(); 
    for (int i = 0; i < aliens.length; i++) 
    {
      Alien validAlien = aliens[i];
      if (!validAlien.exploding && !validAlien.exploded)
      {
        validAliens.add(validAlien);
      }
    }
    
    // If there are valid aliens, select a random one and drop the bomb from underneath it
    if (!validAliens.isEmpty()) 
    {
      int randomAlienIndex = (int) random(validAliens.size());
      Alien randomAlien = validAliens.get(randomAlienIndex);
      
      float centerX = randomAlien.x + alienWidth / 2; // Calculate the center x position of the alien
      float randomX = centerX - BOMB_WIDTH / 2; // Adjust the x position to place the bomb underneath the alien
      float randomY = randomAlien.y + alienHeight;
      bombs.add(new Bomb(randomX, randomY));
    }
  }
}

Bomb theBomb;
