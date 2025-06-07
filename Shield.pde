class Shield 
{
  float x;
  float y;
  float rectWidth = (PADDLEWIDTH + 20) / 10;
  float rectHeight = 20;
  int numRectangles = 10;
  boolean[] rectangles;
  float shieldYPosition;

  Shield(float x, float y) 
  {
    this.x = x;
    this.y = y;
    shieldYPosition = y;
    rectangles = new boolean[numRectangles];
    for (int i = 0; i < numRectangles; i++) 
    {
      rectangles[i] = true; // All rectangles initially active
    }
  }

  void draw() 
  {
    fill(0, 300, 0);
    for (int i = 0; i < numRectangles; i++) 
    {
      if (rectangles[i]) 
      {
        rect(x + i * rectWidth, y, rectWidth, rectHeight);
      }
    }
  }

  void removeFirstRectangle() 
  {
    for (int i = 0; i < numRectangles; i++) 
    {
      if (rectangles[i]) 
      {
        rectangles[i] = false;
        break;
      }
    }
  }

  void removeFirstThreeRectangles() 
  {
    int removedCount = 0;
    for (int i = 0; i < numRectangles; i++) 
    {
      if (rectangles[i]) 
      {
        rectangles[i] = false;
        removedCount++;
        if (removedCount >= 3) 
        {
          break;
        }
      }
    }
  }
  
  boolean areAllRectanglesGone() 
  {
    for (int i = 0; i < numRectangles; i++) 
    {
        if (rectangles[i]) 
        {
            return false; // At least one rectangle is still active
        }
    }
    return true; // All rectangles are gone
  }
  
}

Shield shield1;
Shield shield2;


   
