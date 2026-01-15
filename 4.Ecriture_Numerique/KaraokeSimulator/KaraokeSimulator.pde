import java.util.Random;
import arb.soundcipher.*;

Random rand = new Random();
SoundCipher sc = new SoundCipher(this);

int bpm = 30;
int currentBpm = bpm;
int lastStepTime = 0;

float[] Accord0 = {60, 64, 67};
float[] Accord1 = {62, 65, 69};
float[] Accord2 = {64, 67, 71};
float[] Accord3 = {65, 69, 72};
float[] Accord4 = {67, 71, 74};
float[] Accord5 = {69, 72, 76};
float[] Accord6 = {71, 74, 77};
float[] Accord7 = {60, 67, 74, 79};

float[][] listeAccords = {Accord0,Accord1,Accord2,Accord3,
Accord4,Accord5,Accord6,Accord7};

float hueValue = 0;

// Listes de mots
String[] names = {
  "Mila", "Corentin", "Lalie","Lucille","Yasmine","Kellian","Jade","Romane","Agathe","Léna","Marine","Laïn",
  "Raphael","Alexandre","Éléa","Chloé","Elouan","Souksana","Benoît","Julien","Roméo","Justine",
  "Julie", "Romana", "Matthieu", "Qays", "Alina", "Yanis", "Nils"
};

String[] adjectives = {
  "lumineux",
  "fatigué",
  "bruyant",
  "fragile",
  "tendre",
  "bancal",
  "heureux",
  "nerveux",
  "curieux",
  "lent",
  "féroce",
  "calme",
  "étrange",
  "serein",
  "amer",
  "léger",
  "pesant",
  "silencieux",
  "timide",
  "fou"
};


String[] nouns = {
  "joie",
  "peur",
  "silence",
  "attente",
  "désordre",
  "souvenir",
  "vertige",
  "habitude",
  "absence",
  "envie",
  "doute",
  "élan",
  "fatigue",
  "colère",
  "tendresse",
  "vide",
  "chaleur",
  "faim",
  "espoir",
  "regret"
};


String[] adverbs = {
  "lentement",
  "brusquement",
  "doucement",
  "maladroitement",
  "souvent",
  "rarement",
  "silencieusement",
  "violemment",
  "à peine",
  "longtemps",
  "parfois",
  "toujours",
  "nerveusement",
  "calmement",
  "étrangement"
};

String[] verbs = {
  "mange",
  "regarde",
  "attend",
  "cherche",
  "évite",
  "observe",
  "gamberge",
  "oublie",
  "espère",
  "doute",
  "tombe",
  "avance",
  "recule",
  "écoute",
  "sourit",
  "rit",
  "tremble",
  "respire",
  "arrête",
  "continue"
};

String[] complements = {
  "dans le noir",
  "sans raison",
  "le matin",
  "dans la rue",
  "à voix basse",
  "contre le mur",
  "au hasard",
  "sous la pluie",
  "dans le silence",
  "avec patience",
  "sans y penser",
  "en boucle",
  "au fond",
  "à distance",
  "dans l'attente"
};

void setup(){
  size(600,600);
  // Pas d’affichage graphique
  //noLoop();
  println("");
  sc.tempo(bpm);
  noStroke();
}

void draw(){
  if (millis() - lastStepTime > 60000 / currentBpm) {
    currentBpm = bpm;
    String text = body();
    println(text);
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(text,300,300);
    lastStepTime = millis();
  }
  colorMode(HSB, 360, 100, 100);
  hueValue = (hueValue + 1) % 360;
  fill(hueValue, 80, 90);
  strokeWeight(2);
  rect(0,0,600,250);
  rect(0,350,600,250);
  fill(0);
  textSize(50);
  text("KaraokeSimulator",300, 100);
}


// Fonctions utilitaires
String choice(String[] words){
  return words[int(random(words.length))];
}

String maybe(String[] words){
  if (rand.nextBoolean()){
    return choice(words)+" ";
  }
  return "";
}

String longer(){
  return maybe(adjectives)
    + choice(nouns)
    + " "
    + maybe(adverbs)
    + choice(verbs)
    + " "
    + choice(complements);
}

String shorter(){
  return " " + choice(verbs) +" "+ maybe(adverbs)+choice(complements);
}

String body(){
  String text = "";
    if (rand.nextBoolean()) {
      text += longer();
      playChord(getChord(text),2);
      currentBpm /= 2;
    } else if (rand.nextBoolean()){
        text += choice(names)+" tu" + shorter();
        playChord(getChord(text),1);
    } else{
      text += "Je" + shorter();
      playChord(getChord(text),1);
    }
  return text;
}

void playChord(float[] pitches,int length){
      sc.playChord(pitches, 50+random(50), length);
}
  
float[] getChord(String line){
  line = line.toLowerCase();
  int moyenne = 0;
  for(int i =0; i<line.length();i++){
    if(line.charAt(i)!=32){
      moyenne +=line.charAt(i);
    }
  }
  moyenne /= line.length();
  moyenne %= 8;
  return listeAccords[moyenne];
}
