final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
final int MARGIN = 10;
final int BULLET_COOLDOWN = 400; 

class Player 
{
  int xpos; 
  int ypos;
 
  Player(int screen_y)
  {
    xpos=SCREENX/2;
    ypos=screen_y;
  }
  
  void move(int x)
  {
    if (x <= 0)
     xpos = 0;
    if(x>SCREENX-PADDLEWIDTH) 
      xpos = SCREENX-PADDLEWIDTH;
    else 
      xpos = x;
  }
  
  void draw()
  {
     color paddlecolor1 = color(200, 0, 128);
     fill (paddlecolor1);
     rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
     rect(xpos + 18, ypos - 10, PADDLEWIDTH/3, PADDLEHEIGHT/3);

     for (int i = 0; i < bullets.size(); i++) 
     {
        Bullet bullet = bullets.get(i);
        bullet.move();
        bullet.draw();
     }
  }
  
  float getX() 
  {
    return xpos + 26;
  }

  float getY() 
  {
    return ypos - 10;
  }
  
}

Player theHumanPlayer;
