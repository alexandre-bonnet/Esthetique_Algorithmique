import java.util.Random;
Random rand = new Random();

void setup(){
    size(400,500);
    noLoop();
    noStroke();
}
    
void draw(){
  background(0);
  drawBg();
  fill(227,192,75);
  ellipse(mouseX,mouseY, 100,100);
  for(int i = 0; i <500;i+=50){
    for(int j = 200; j <600;j+=50){
      j+=rand.nextInt(5)*5;
      i+=rand.nextInt(5)*5;
      drawCloud(i,j);
    }
  }
}

void mousePressed() {
  redraw();
}

//Cette fonction dessine le background avec plusieurs couleurs
void drawBg(){
  color c1 = color(235-mouseY/2, 146-mouseY/5, 137-mouseY/6); //Couleur Bas
  color c2 = color(128-mouseY/5, 177-mouseY/5, 196-mouseY/7); //Couleur Haut
  fill(c1);
  rect(0,250,400,300);
  fill(c2);
  rect(0,0,400,250);
  noFill();
  //Nous dessinons plein de lignes l'une apres l'autre en changeant légèrement la couleur afin d'avoir un dégradé
  for (int i = 0; i <= 200; i++) {
      float inter = map(i, 0, 200, 0, 1);
      color c = lerpColor(c2, c1, inter);
      stroke(c);
      line(0, 100+i, 400, 100+i);
  }
  noStroke();
}

//Cette fonction nous permet de dessiné un nuage 
//Chaque nuage est composé d'un cercle principal et de 4 cerlcles autour
void drawCloud(int x, int y){
  int dPos=0; //variation de position des ellipses
  int dSize=0; //variation de taille des ellipses
  int h = 80+rand.nextInt(4)*10;
  color cloudColor = color(230-mouseY/5);
  shadedEllipse(x,y,h,cloudColor);
  dPos = rand.nextInt(20);
  dSize = rand.nextInt(20);
  shadedEllipse(x+20+dPos,y+dPos,(int)(0.5*h+dSize),cloudColor);
  dPos = rand.nextInt(20);
  dSize = rand.nextInt(20);
  shadedEllipse(x+20+dPos,y,(int)(0.5*h+dSize),cloudColor);
  dPos = rand.nextInt(20);
  dSize = rand.nextInt(20);
  shadedEllipse(x-20-dPos,y+dPos,(int)(0.5*h+dSize),cloudColor);
  dPos = rand.nextInt(20);
  dSize = rand.nextInt(20);
  shadedEllipse(x-20-dPos,y,(int)(0.5*h+dSize),cloudColor);
  return;
}

//Ceci sert à desiner le nuage ainsi que son ombre.
//Les ombres suivent l'emplacement du soleil
void shadedEllipse(int x, int y, int h, color cloudColor) {
  fill(cloudColor);
  ellipse(x, y, h, h);
  color dark = lerpColor(cloudColor, color(0), 0.35);
  fill(dark, 130);
  pushMatrix();
  translate(x, y);
  rotate(atan2(mouseY-y,mouseX-x)+PI/2);
  ellipse(0, h*0.17, h*0.95, h*0.70);
  popMatrix();
  noClip();
}
