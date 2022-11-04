//your code here
Particle[] pp = new Particle[100];
PImage reimu;
PImage cirno;
boolean pause = false;
ArrayList<IParticle> p = new ArrayList<IParticle>();
void keyReleased(){
  if (key == ' ') pause = !pause;
  if (key == 'c') p = new ArrayList<IParticle>();
  if (key == 'r') {pp = new Particle[50];mouseClicked();}
  if (keyCode == RETURN || keyCode == ENTER) {mouseClicked();}
}
void mouseClicked() {
  pp = new Particle[pp.length*2];
  for (int i=0;i<pp.length/2;i++) {
    pp[i] = new Particle(Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*10+10, Math.random()*5+5, 85+Math.random()*10, -Math.random()*2, new int[]{180,180,200+(int)(Math.random()*55), 0, 0});
  }
  for (int i=pp.length/2;i<pp.length;i++) {
    pp[i] = new Particle((width/2)+Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*10+10, Math.random()*5+5, 85+Math.random()*10, Math.random()*2, new int[]{180, 180,200+(int)(Math.random()*55), 0, 0});
  }
  pp[0] = new OddballParticle(Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*20+20, 5, 90, -2, new int[]{255,0,0, 0, 0});

}
void setup()
{
	//your code here
  size(500,500);
  reimu = loadImage("reimu.png");
  reimu.resize(0, (int)(height*.1));
  cirno = loadImage("cirno.png");
  cirno.resize(0, (int)(height*.2));
  for (int i=0;i<pp.length/2;i++) {
    pp[i] = new Particle(Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*10+10, Math.random()*5+5, 85+Math.random()*10, -Math.random()*2, new int[]{180,180,200+(int)(Math.random()*55), 0, 0});
  }
  for (int i=pp.length/2;i<pp.length;i++) {
    pp[i] = new Particle((width/2)+Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*10+10, Math.random()*5+5, 85+Math.random()*10, Math.random()*2, new int[]{180, 180,200+(int)(Math.random()*55), 0, 0});
  }
  pp[0] = new OddballParticle(Math.random()*(width/2+1), Math.random()*(height/3), Math.random()*20+20, 5, 90, -2, new int[]{255,0,0, 0, 0});
}
void draw()
{
	//your code here
  if (pause)return;
  background(0,0,10);
  for (int i=0;i<pp.length;i++) {
    pp[i].move();
    pp[i].show();
    if (frameCount % 30 == 0 && width/2+(reimu.width/2) > pp[i].x && width/2-(reimu.width/2) < pp[i].x && height*.8-reimu.height/2 < pp[i].y && height*.8+reimu.height/2 > pp[i].y) {
      p.add(new IParticle(pp[i].x, pp[i].y, width/30, loadImage("p.png"), 1, Math.random()*360, 0));
    }
  }
  image(reimu, width/2-reimu.width/2, height*.8-reimu.height/2);
  image(cirno, width/2-cirno.width/2, height*.2-cirno.height/2);
  for (int i=0;i<p.size();i++) {
    p.get(i).move();
    p.get(i).show();
    if (p.get(i).x < 0 || p.get(i).y < 0 || p.get(i).x > width || p.get(i).y > height) {
      p.remove(i);
      i--;
    }
  }
  String info = "Bullets: "+pp.length+" FPS: "+Math.round(frameRate);
  fill(0,0,0,100);
  noStroke();
  rect(width/2-textWidth(info)/2-width/20, 0, textWidth(info)+(width/20)*2, height/20+height/40);
  fill(255,255,255);
  stroke(255,255,255);
  text(info, width/2-textWidth(info)/2, height/20);
}
class Particle
{
	protected double x;
  protected double y;
  protected double size;
  protected double speed;
  protected double angle;
  protected double rotVel;
  protected int[] col;
  public Particle(double x, double y, double size, double speed, double angle, double rotVel, int[] col) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.angle = angle;
    this.col = col;
    this.rotVel = rotVel;
    this.size = size;
  } 
  public void move() {
    angle += rotVel;
    x += Math.cos(radians((float)angle))*speed;
    y += Math.sin(radians((float)angle))*speed;
  }
  public void show() {
    pushMatrix();
    translate((float)x,(float)y);
    rotate(radians((float)angle));
    noStroke();
    fill(col[0], col[1], col[2]);
    ellipse(0,0, (float)size, (float)size);
    popMatrix();
  }
}
class IParticle extends Particle {
  private PImage image_;
  public IParticle(double x, double y, double size, PImage image_, double speed, double angle, double rotVel) {
    super(x, y, size, speed, angle, rotVel, new int[]{});
    this.image_ = image_;
    this.image_.resize((int)size, 0);
  } 
  void show() {
    pushMatrix();
    translate((float)x,(float)y);
    noStroke();
    image(this.image_, 0, 0);
    //fill(col[0], col[1], col[2]);
    //ellipse(0,0, (float)size, (float)size);
    popMatrix();
  }
}

class OddballParticle extends Particle//inherits from Particle
{
	//your code here
  public OddballParticle(double x, double y, double size, double speed, double angle, double rotVel, int[] col) {
    super(x, y, size, speed, angle, rotVel, col);
  }
  void show() {
    pushMatrix();
    translate((float)x,(float)y);
    rotate(radians((float)angle));
    noStroke();
    fill(col[0], col[1], col[2]);
    ellipse((float)size, (float)size, (float)size, (float)size);
    popMatrix();
  }
}
