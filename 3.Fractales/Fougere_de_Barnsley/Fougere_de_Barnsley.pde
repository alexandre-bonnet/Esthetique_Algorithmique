float x = 0;
float y = 0;
float level = 0;

//on crée les variables présentes dans la formule
int a=1, b=2, c=3, d=4, e=5, f=6, p=7;
//index de la fonction courrante

//on crée les coefficients de l'équation de la fougère de Barnsley
float[] f0 = {0,0,0,0,0.16,0,0,0.01};
float[] f1 = {1,0.85,0.04+level,(-0.04),0.85,0,1.60,0.85};
float[] f2 = {2,0.20,(-0.26),0.23,0.22,0,1.60,0.07};
float[] f3 = {3,(-0.15),0.28,0.26,0.24,0,0.44,0.07};

//on crée un tableau de tableaux afin de référencer les différentes fonctions
float[][] fonction = {f0,f1,f2,f3};

void setup(){
  size(600, 600);
  surface.setLocation(100, 100);
  surface.setAlwaysOnTop(true);
  //noLoop();
  background(0);
  audioSetup();
}

void draw(){
  background(0);
  println(amp.analyze());
  level = map(amp.analyze()*8,0,1,(-0.01),0.09);
  f1[2] =0.04-level;
  //on dessine une fougère par cycle
  for(int i = 0; i<10000; i++){
    drawPoint();
    updatePoint();
  }
}

void drawPoint(){
  stroke(50,int(random(200)+54),50);
  strokeWeight(3);
  // nous modifions le systeme de coordonnées
  float px = map(x,-2.2,2.6,0,width);
  float py = map(y,0,10,height,0);
  point(px,py);
}

void updatePoint(){
  float nextX;
  float nextY;
  float proba = random(1);
  float probaSum = 0;
  int index = -1;
  for(int i = 0;i<4;i++){
    //on ajoute à la somme la proba actuelle.
    probaSum+=fonction[i][p];
    if(probaSum>=proba){
      index = i;
      break;
    }
  }
  //fonctions de calcul matriciel pour avoir x et y suivant les fonctions
  nextX = fonction[index][a]*x + fonction[index][b]*y + fonction[index][e];
  nextY = fonction[index][c]*x + fonction[index][d]*y + fonction[index][f];
  //println(fonction[index][a]+"*x +"+fonction[index][b]+"*y +"+fonction[index][e]+" = "+nextX);
  //println(fonction[index][c]+"*x +"+fonction[index][d]+"*y +"+fonction[index][f]+" = "+nextY);
  //println("======================== "+index);
  x = nextX;
  y = nextY;
}
