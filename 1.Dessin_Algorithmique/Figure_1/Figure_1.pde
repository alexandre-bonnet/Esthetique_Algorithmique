//Résolution de l'écran
int a = 0;

void setup(){
    size(640,400);
    background(0);
    noFill();
    color b1 = color(0,255,0);
    stroke(b1);
}
    
void draw(){
  int n = 0;
  int d=0;
  int x = 640;
  int y = 400;
   while(n<y){
   a = a%255;
    delay(2);
    d+=1;
    strokeWeight(d);
    n+=d+1;
    x=x-d-10;
    y=y-d-10;
    rect(n,n,x-n,y-n);
    a+=1;
    stroke(0,(a+n*2)%255,0);
  }
}
