ArrayList<Bullet> bullets = new ArrayList<>(50);
int currentBulletIndex = 0;
int collidedIndex = -1; 
long lastBulletTime = 0; 
final int DISTANCE_FROM_PADDLE_CENTER_TO_SIDE = 30;
final int BULLET_RADIUS = 8;

class Bullet {
  float x; 
  float y; 
  float speed = 60; 
  color bulletColor; 
  int speedIncrement = 12;
  
  Bullet(float x, float y, float speed, color bulletColor) 
  {
    this.x = x;
    this.y = y;
    if (speedPowerUpActive == true )
    {
      this.speed = speed*speed*speedIncrement;
    }
    else if (fireBallPowerupActive == true || doubleBulletPowerupActive == true)
    {
      this.speed = speed*speedIncrement;
    }
    else
    {
      this.speed = speed;
    }
    
    this.bulletColor = bulletColor;
  }

  void move() 
  {
    y  -= speed;   
  }

  void draw() 
  {
    if (doubleBulletPowerupActive == true) 
    {
        fill(bulletColor);
        ellipse(x -  DISTANCE_FROM_PADDLE_CENTER_TO_SIDE, y, BULLET_RADIUS, BULLET_RADIUS); 
        fill(bulletColor);
        ellipse(x + DISTANCE_FROM_PADDLE_CENTER_TO_SIDE, y, BULLET_RADIUS, BULLET_RADIUS); 
    }
    else if (fireBallPowerupActive == true)
    {
        image(fireballImage, x - (DISTANCE_FROM_PADDLE_CENTER_TO_SIDE/2), y, 30, 40);
    }
    else
    {
        fill(bulletColor);
        ellipse(x, y, BULLET_RADIUS, BULLET_RADIUS); 
    }
    
    int collidedIndex = collide(aliens);
    if (collidedIndex != -1) 
    {
        aliens[collidedIndex].explode();
    }
  }

  boolean checkCollision (float targetX, float targetY, float targetWidth, float targetHeight) 
  {
    if (x >= targetX && x <= targetX + targetWidth && y >= targetY && y <= targetY + targetHeight)
    {
      return true;
    }
    return false;
  }
  
  int collide(Alien[] aliens) 
  {
    collidedIndex = -1; 
    for (int i = 0; i < aliens.length; i++) 
    {
      if (!aliens[i].exploded && checkCollision(aliens[i].x, aliens[i].y, alienWidth, alienHeight)) 
      {
        collidedIndex = i; // Return the index of the collided Alien
        aliens[i].explode();
      }
    }
    
    if (fireBallPowerupActive == true) 
    {
      int i = 0;
      while (i < aliens.length) 
      {
        if (aliens[i].exploded == false && checkCollision(aliens[i].x, aliens[i].y, alienWidth, alienHeight) == true) 
        {
            int startIndex = max(0, i - 1); 
            int endIndex = min(aliens.length - 1, i + 1); 

            for (int j = startIndex; j <= endIndex; j++) {
                aliens[j].explode();
            }

            i = endIndex + 1;
         } 
        else 
        {
            i++;
        }
      }
    }
    return collidedIndex; // Return -1 if no collision occurred
  }
  
  int collideExceptIndex(Alien[] aliens, int excludeIndex) 
  {
    int collidedIndex = -1;
    for (int i = 0; i < aliens.length; i++) 
    {
        if (aliens[i].exploded && i != excludeIndex) {
            collidedIndex = i;
            break;
        }
    }
    return collidedIndex;
  }
}

Bullet bullet;
