SoundFile[] sample = new SoundFile[nbSingers];
Amplitude[] amp = new Amplitude[nbSingers];
int jump = 0;

void audioSetup(){
  for( int i = 0; i<nbSingers;i++){
    sample[i] = new SoundFile(this, "sample"+i+".mp3");
    amp[i]= new Amplitude(this);
    amp[i].input(sample[i]);
  }
  //on les lance dans le même boucle pour limiter les délais
  for( int i = 0; i<nbSingers;i++){
  sample[i].jump(jump);
  }
}
