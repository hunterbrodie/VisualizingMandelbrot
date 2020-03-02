int maxIterations = 100;
float hRadius;
float wRadius;
float zoom = hRadius / 5;
float[] center = { 0 , 0 };
float x, y;
float limit = 150f;
color storedColor;
color[][] screen;

void setup()
{
  background(255);
  fullScreen();
  screen = new color[width][height];
  hRadius = 2;
  wRadius = (hRadius * width) / height;
  generateFractal();
  update(); //<>//
}

void draw()
{
   //<>//
}

void mouseClicked()
{
  if (mouseButton == LEFT)
  {
    float mouseXf = (float)(mouseX);
    float mouseYf = (float)(mouseY);
    float percentX = mouseXf / width;
    float percentY = mouseYf / height;
    float graphX = percentX * wRadius * 2;
    float graphY = percentY * hRadius * 2;
    graphX = graphX - wRadius;
    graphY = graphY - hRadius;
    
    center[0] = graphX + center[0]; //<>//
    center[1] = graphY + center[1]; //<>//
    
    float zoom = hRadius / 4;
    hRadius = hRadius - zoom; //<>//
    
    generateFractal();
    update();
  }
  else if (mouseButton == RIGHT)
  {
    hRadius = 2;
    wRadius = (hRadius * width) / height;
    
    center[0] = 0;
    center[1] = 0;
    
    generateFractal();
    update();
  }
}

private void generateFractal()
{
  wRadius = (hRadius * width) / height;
  float dx = (wRadius * 2) / width;
  float dy = (hRadius * 2) / height;
  x = -wRadius + center[0];
  for (int i = 0; i < width; i++)
  {
    y = -hRadius + center[1];
    for (int j = 0; j < height; j++)
    {
      int n = mandelbrot(x, y, 0);
      if (n == maxIterations)
      {
        screen[i][j] = color(0);
      }
      else
      {
        screen[i][j] = getColor(map(sqrt(map(n, 0, maxIterations, 0, 1)), 0, 1, 20, 255));
      }
      y += dy;
    }
    x += dx;
  }
}

private int mandelbrot(float a, float b, int n)
{
  float aa = a * a;
  float bb = b * b;
  float twoab = 2.0 * a * b;
  a = aa - bb + x;
  b = twoab + y;
  if (n == maxIterations || dist(aa, bb, 0, 0) > 4f)
  {
    return n;
  }
  else
  {
    n++;
    n = mandelbrot(a, b, n);
    return n;
  }
}

private void update()
{
  for (int i = 0; i < width; i++)
  {
    for (int z = 0; z < height; z++)
    {
      set(i, z, screen[i][z]);
    }
  }
  textSize(32);
  text("Left Click to zoom in || Right Click to zoom out || Esc to exit", 10, 30); 
}

private color getColor(float value)
{
  color shade;
  if ( value > 230 )
  {
    shade = color(255, 255, 255);
  }
  else if ( value > limit )
  {
    shade = color(value, value, 0);
  }
  else
  {
    shade = color(0, 0, value);
  }
  
  return shade;
}
