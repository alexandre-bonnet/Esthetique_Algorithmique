import processing.sound.*;
import java.util.Random;
Random rand = new Random();

int nbSingers = 7;

int[][] colorTab = {{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0},{0,0,0}}; //tableau des couleurs de chaque chanteur
boolean[] active = new boolean[nbSingers]; //Stocke l'étât des chanteurs, actifs/inactifs
float[] levels = new float [nbSingers]; //Stocke le niveau de volume des chanteurs
//Stocke la position des chanteurs
float[] px = new float[nbSingers];
float[] py = new float[nbSingers];
PImage bg;

void setup() {
  size(600, 600);
  bg = loadImage("background.jpg");
  surface.setLocation(100, 100);
  surface.setAlwaysOnTop(true);
  audioSetup();
  choirSetup();
}

// génère des couleurs et vérifié l'état des chanteurs
void choirSetup(){
  getSingerPositions();
  for(int i =0; i< nbSingers;i++){
    for(int j = 0; j<3;j++){
      colorTab[i][j] = 100+(int)random(100);
    }
    active[i] = rand.nextBoolean();
    levels[i] = 0;
    if(!active[i]){
      sample[i].amp(0.0); 
    }
  }
}

void draw() {
  image(bg,0,0);
  updateLevels();
  drawOrchestra();
}

//Met à jour le niveau de volume des chanteurs
void updateLevels(){
  for(int i = 0;i<nbSingers;i++){
    levels[i] = lerp((constrain(amp[i].analyze(),0.06,150)*70),0,0.25);
  }
}

//vérifie où le clic s'est passé, si il a été effectué sur la tête d'un chanteur, celui-ci change d'état
void mousePressed(){

  for (int i = 0; i < nbSingers; i++) {
    float y = py[i]-190;
    float x = px[i];
    if (!active[i]) y += 50; //Si le personnage est désactivé il est plus bas

    if (dist(mouseX, mouseY, x, y) <= 60) {
      changeSinger(i);
    }
  }
}

void keyPressed(){
  if(key>'0'&&key<'8'){
    changeSinger(key-'1');
  }
}

void changeSinger(int i){
      if(active[i]){
      sample[i].amp(0.0); 
    } else { 
      sample[i].amp(1.0); 
    }
      active[i]=!active[i];
}

void drawOrchestra(){
  noStroke();
  for (int i = 0; i < nbSingers; i++) {
  drawPersonnage(px[i],py[i],i);
  }
}

void drawPersonnage(float x, float y, int perso) {
  boolean darker = false;
  if(!active[perso]){
    y += 50;
    darker = true;
  }
  float torsoW = 180;
  float torsoH = 280;
  float headD = 120;

  //Dessin Torse
  if(darker){
    fill(100);
  } else {
  fill(color(colorTab[perso][0],colorTab[perso][1],colorTab[perso][2]));
  }
  ellipse(x, y, torsoW, torsoH);

  //Dessin Tête
  float headX = x;
  float headY = y - torsoH/2 - headD/2 + 10;
  if(darker){
    fill(150);
  } else {
  fill(255, 220, 180);
  }
  ellipse(headX, headY, headD, headD);

  //Dessin yeux
  float eyeOffsetX = 22;
  float eyeY = headY - 10;
  fill(0);
  ellipse(headX - eyeOffsetX, eyeY, 15, 15);
  ellipse(headX + eyeOffsetX, eyeY, 15, 15);
  textSize(30);
  fill(color(colorTab[perso][0]-50,colorTab[perso][1]-50,colorTab[perso][2])-50);
  text(""+(perso+1),x-10, y-50);

  //Dessin Bouche
  if(darker){
    fill(170);
  } else {
    fill(200,50,50);
  }
  strokeWeight(0);
  ellipse(headX, headY + 25, 45, levels[perso]);
  noStroke();
}

void getSingerPositions() {
  int lineCount = nbSingers-(nbSingers + 1) / 2; // ceil
  int space = 150;
  int yPos = 400;
  int index = 0;

  
  for(int i = 0; i<2;i++){
    float startX = width/2- (lineCount - 1) * space / 2.0;
    for (int j = 0; j < lineCount; j++){
      px[index] = startX + j * space;
      py[index] = yPos;
      println( px[index]+"/"+py[index]);
      index++;
  }
    lineCount = nbSingers - lineCount;
    yPos += 150;
  }
}
