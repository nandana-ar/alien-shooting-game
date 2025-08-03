PImage invader;    
PImage explodeImage;
float speedX = 2.5;    
float speedY = 0;       

class Alien 
{
  float x;
  float y;
  float initialX;
  float initialY;
  boolean movingRight;
  boolean exploding;        
  int explosionStartTime;   // Time when the explosion started
  boolean exploded;
  float accelerationRate;  
  float currentSpeedX; 

  Alien(float x, float y) 
  {
    this.x = x;            
    this.y = y;           
    this.initialX = x;     
    this.initialY = y;     
    this.movingRight = true;
    this.exploding = false;
    this.explosionStartTime = 0;
    this.exploded = false;
    this.accelerationRate = 0.35; // The acceleration rate
    this.currentSpeedX = speedX; 
  }

  void move() 
  {
    if (movingRight) 
    {
      x += speedX;
    } 
    else 
    {
      x -= speedX;
    }
    
    if (x <= 0 || x + alienWidth >= width) 
    {
      y += alienWidth;
      movingRight = !movingRight;   
    }
  }
 
  void draw() 
  {
    if (exploding==true && exploded == false) 
    {
      drawExplosion();
    } 
    else if (exploded == false)
    {
      invader = new PImage();         
      invader = loadImage
        ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/invader - white.GIF");
      image(invader, x, y, alienWidth, alienHeight); 
    }
  }
  
  void explode()   // Set the explosion start time and flag the alien as exploding
  {
    explosionStartTime = millis();
    exploding = true;
    drawExplosion();
  }

  void drawExplosion() 
  {
    if (exploding == true && exploded == false) 
    {
      int explosionDuration = 1300; 
      int elapsedTime = millis() - explosionStartTime;
      if (elapsedTime < explosionDuration) 
      {
        float sizeReductionFactor = random(0.1, 1.0); 
        float currentWidth = alienWidth * sizeReductionFactor;
        float currentHeight = alienHeight * sizeReductionFactor;
        image(explodeImage, x + (alienWidth - currentWidth)/2, y + (alienHeight - currentHeight)/2, currentWidth, currentHeight);
      }
      else
      {
        exploded = true;
      }
    }
  }
}

Alien[] aliens;
