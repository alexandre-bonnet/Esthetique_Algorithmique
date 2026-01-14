import processing.sound.*;

AudioIn in;
Amplitude amp;

void audioSetup(){
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  amp.input(in);
  //in.play();
}
