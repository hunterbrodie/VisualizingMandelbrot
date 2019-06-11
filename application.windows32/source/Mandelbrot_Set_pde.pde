int maxIterations = 100;
float hRadius;
float wRadius;
float zoom = hRadius / 5;
float[] center = { 0 , 0 };
float x, y;

//int[0] = x
//int[1] = y
//int[2] = shade
//ArrayList<float[]> finite = new ArrayList<float[]>();

color storedColor;

void setup()
{
  background(255);
  //size(1280, 720);
  fullScreen();
  hRadius = 2;
  wRadius = (hRadius * width) / height;
  generateFractal();
}

void draw()
{
   //<>//
}

/*boolean search()
{
  boolean inFinite = false;
  for (int count = 0; count < finite.size(); count++)
  {
    if (x == finite.get(count)[0] && y == finite.get(count)[1])
    {
      storedColor = color(finite.get(count)[2]);
      inFinite = true;
      break;
    }
  }
  return inFinite;
}*/

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
    wRadius = (hRadius * width) / height;
    
    generateFractal();
  }
  else if (mouseButton == RIGHT)
  {
    hRadius = 2;
    wRadius = (hRadius * width) / height;
    
    center[0] = 0;
    center[1] = 0;
    
    generateFractal();
  }
}

private void generateFractal()
{
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
        set(i, j, color(0));
      }
      else
      {
        set(i, j, getColor(map(sqrt(map(n, 0, maxIterations, 0, 1)), 0, 1, 20, 255)));
      }
      y += dy;
    }
    x += dx;
  }
}

/*private void generateFractalCheck()
{
  float dx = (wRadius * 2) / width;
  float dy = (hRadius * 2) / height;
  x = -wRadius + center[0];
  for (int i = 0; i < width; i++)
  {
    y = -hRadius + center[1];
    for (int j = 0; j < height; j++)
    {
      search();
      if (search() == false)
      {
        int n = mandelbrot(x, y, 0);
        if (n == maxIterations)
        {
          float[] tempRecord = { x , y , 0 };
          finite.add(tempRecord);
          set(i, j, color(0));
        }
        else
        {
          float[] tempRecord = { x , y , map(sqrt(map(n, 0, maxIterations, 0, 1)), 0, 1, 0, 255) };
          finite.add(tempRecord);
          set(i, j, color(25, 0, map(sqrt(map(n, 0, maxIterations, 0, 1)), 0, 1, 20, 255)));
        }
      }
      y += dy;
    }
    x += dx;
  }
}*/

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

private color getColor(float value)
{
  color shade;
  if ( value > 150 )
  {
    shade = color(value, value, 0);
  }
  else
  {
    shade = color(0, 0, value);
  }
  
  return shade;
}
