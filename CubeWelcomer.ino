/* Quick implementation of Cube Welcomer for Arduino or any compatible board*/

class PresenceSensor {
  private:
    int inputPin = 16;
  public:
    PresenceSensor()
    {
      pinMode(inputPin,INPUT);
    }
    bool check_presence()
    {
      return (!digitalRead(inputPin));
    }
};
    
class SmileySpeakerOutput
{
  private:
    int speakerOutput = 15;
    int smileyOutput = 7;
    unsigned long onDelay = 1000;   
  public:
    SmileySpeakerOutput()
    {
      pinMode(speakerOutput, OUTPUT);
      pinMode(smileyOutput, OUTPUT); 
    }
    void outputs_on()
    {
      digitalWrite(speakerOutput, HIGH);
      digitalWrite(smileyOutput, HIGH);
      delay(onDelay);
      digitalWrite(speakerOutput, LOW);
    }
    void outputs_off()
    {
      digitalWrite(smileyOutput, LOW);
    }
};
                   
class CubeWelcomer
{
  private:
    SmileySpeakerOutput smileySpeaker;
    bool objectInView;
  public:
    CubeWelcomer()
    {
      objectInView = false;
    }
    void to_greet_or_not_to_greet(bool objectPresent)
    {
      if (objectInView == false && objectPresent == true)
      {
        smileySpeaker.outputs_on();
        objectInView = true;
      }
      else if (objectInView == true && objectPresent == false)
      {
        smileySpeaker.outputs_off();
        objectInView = false;
      }
    }
};


CubeWelcomer cubeWelcomer;
PresenceSensor presenceSensor;    


void setup() {
  // put your setup code here, to run once:

}

void loop() {
  cubeWelcomer.to_greet_or_not_to_greet(presenceSensor.check_presence());
  delay(500);
}
