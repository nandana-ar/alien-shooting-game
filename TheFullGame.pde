final int SCREENX = 600;
final int SCREENY = 600;
final float alienWidth = 30;  
final float alienHeight = 25; 
int shieldX1 = 150;
int shieldX2 = 400;
int shieldY = int(alienHeight * 21.5);
int bigRectMadeOfSmallRectWidth1 = 10*10;
int bigRectMadeOfSmallRectWidth2 = 10*10;

void settings()
{
  size(SCREENX, SCREENY);
}

void setup()
{
  theHumanPlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  aliens = new Alien[10];
  init_aliens(aliens);   
  explodeImage = loadImage
     ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/exploding.GIF");
  shield1 = new Shield(shieldX1, shieldY);
  shield2 = new Shield(shieldX2, shieldY);
  doubleBulletPowerup = loadImage
     ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/double bullet - powerup.png");
  speedPowerup = loadImage
     ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/speed - powerup.png");
  firePowerup = loadImage
     ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/bomb - powerup.png");
  fireballImage = loadImage
     ("C:/Users/nanda/Desktop/University/Year 1/Semester 2/Programming Project/Exercises and Tutorials/Week 4/Data/fire - powerup.png");
}

float x;
float y;

void draw() 
{
  
  background(0);
  theHumanPlayer.move(mouseX);
  theHumanPlayer.draw();
  move_array(aliens);
  draw_array(aliens);
  shield1.draw();
  shield2.draw();
 
  if (mousePressed)
  {
    mousePressed();
  }
  
  for (int i = bullets.size()-1; i >= 0; i--) 
  {
    Bullet bullet = bullets.get(i); 
    if(doubleBulletPowerupActive == false)
    {
       
    int collidedIndex = bullet.collide(aliens);
    if (collidedIndex != -1) 
    {
      aliens[collidedIndex].explode();
    }
    }
    
    else
    {
      Bullet firstBullet = new Bullet(bullet.x - 30, bullet.y, bullet.speed, bullet.bulletColor);
      int firstCollidedIndex = firstBullet.collide(aliens);
      if (firstCollidedIndex != -1) {
        aliens[firstCollidedIndex].explode();
      }
      
      Bullet secondBullet = new Bullet(bullet.x + 30, bullet.y, bullet.speed, bullet.bulletColor);
      int secondCollidedIndex = secondBullet.collideExceptIndex(aliens, firstCollidedIndex+1);
      if (secondCollidedIndex != -1) {
        aliens[secondCollidedIndex].explode();
      }
    }
     
    
    if(!shield1.areAllRectanglesGone())
    {
      if (bullet.checkCollision (shieldX1, shieldY, bigRectMadeOfSmallRectWidth1 , 20.0)) 
      {
        shield1.removeFirstRectangle();
        bigRectMadeOfSmallRectWidth1 -=10;
        bullets.remove(i);
        shieldX1+=5;
        
      }
    }
    
    if(!shield2.areAllRectanglesGone()){
      if (bullet.checkCollision (shieldX2, shieldY, bigRectMadeOfSmallRectWidth2 , 20.0)) 
      {
        shield2.removeFirstRectangle();
        bigRectMadeOfSmallRectWidth2 -=10;
        bullets.remove(i);
        shieldX2+=5;
      }
    }
  }
  
  boolean allAliensExploded = true;
  for (int i = 0; i < aliens.length; i++) 
  {
    if (!aliens[i].exploded) 
    {
        allAliensExploded = false;
        break;
    }
  }
  
  if (allAliensExploded) 
  {
     noActiveBombs = true;
     PFont winnerFont = loadFont("AgencyFB-Bold-48.vlw");
     fill(0, 300, 0);
     textFont(winnerFont);
     textAlign(CENTER, CENTER);
     text("You Win", width/2, height/2);
     textSize(30);   
     stop();
   }
   
   
   
      if (millis() - lastPowerupTime >= powerupInterval) 
   {
      dropPowerup();
      lastPowerupTime = millis();
   }
  
  for (int i = powerups.size()-2; i >= 0; i--) 
  {
    Powerup powerup = powerups.get(i);
    powerup.updateMovement();
    powerup.draw();

    if (powerup.y >= SCREENY) 
    {
        powerups.remove(i);
        dropPowerup();
    } 
    else 
    {
        if (powerup.collidesWithPlayer(theHumanPlayer)) 
        {
            applyPowerupEffect(powerup.getType());
            powerups.remove(i);
        }
    }
  
  }
   
   
   
   
   
   
   
  for (int i = bombs.size() - 1; i >= 0; i--) 
  {
    Bomb theBomb = bombs.get(i);
    theBomb.move();
    theBomb.draw();
    if (theBomb.collide(theHumanPlayer)) 
    {
      displayGameOverMessage();
      bombs.remove(i);
      stop();
    } 
    else if (theBomb.offScreen()) 
    {
      bombs.remove(i);
    }
    else
    {
      if(!shield2.areAllRectanglesGone())
      {
        if (theBomb.collide(shield2))
        {
          shield2.removeFirstThreeRectangles();
          bombs.remove(i);
        }
      }
      
      if(!shield1.areAllRectanglesGone())
      {
        if(theBomb.collide(shield1))
        {
          shield1.removeFirstThreeRectangles();
          bombs.remove(i);
        }
      }
    }
  }
  
  if (millis() - lastBombTime >= bombInterval && bombs.isEmpty()) 
  {
    dropBomb();
    lastBombTime = millis();
  }
  
}

void init_aliens(Alien[] aliens)
{
  for (int i = 0; i < aliens.length; i++) 
  {
      aliens[i] = new Alien(i * 30, 0); 
  }
}

void draw_array(Alien aliens[])
{
  for(int i=0; i<aliens.length; i++)
    aliens[i].draw();
}

void move_array(Alien aliens[])
{
  for(int i=0; i<aliens.length; i++)
    aliens[i].move();
}

void displayGameOverMessage()
{
  PFont gameOverFont = loadFont("AgencyFB-Bold-48.vlw");
  fill(300, 0, 0);
  textFont(gameOverFont);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/2);
  textSize(30);   
}

void mousePressed() 
{
  long currentTime = millis(); 
  if (currentTime - lastBulletTime >= BULLET_COOLDOWN) 
  {
    bullets.add(new Bullet(theHumanPlayer.getX(), theHumanPlayer.getY(), 2, color(255)));
    lastBulletTime = currentTime; // Update the last bullet firing time
  }
}
