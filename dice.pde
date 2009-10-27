class Led {
 private:
   int pin;
   int state;
 public:
   Led();
   Led(int pin);
   void SetPin(int p);
   void TurnOn();
   void TurnOff();
   boolean IsOn();
};

Led::Led() {
  state = LOW;
};

Led::Led(int pin) {
  state = LOW;
  SetPin(pin);
};

void Led::SetPin(int p) {
  pin = p + 10;
  pinMode(pin,OUTPUT);
};

void Led::TurnOn() {
  state = HIGH;
  digitalWrite(pin, state);
}

void Led::TurnOff() {
  state = LOW;
  digitalWrite(pin, state);
}

boolean Led::IsOn() {
 return state == HIGH; 
}

class FlashingLed : Led {
 private:
   long previousMillis;
   long interval; 
 public:
   FlashingLed();
   void Blink();
};

FlashingLed::FlashingLed() : Led() {
  previousMillis = 0;
  interval = 1000;
}

void FlashingLed::Blink() {
  if (millis() - previousMillis < interval)
    return;
  previousMillis = millis();   
  if( IsOn() )
    TurnOff();
  else
    TurnOn();
};

class Face {
  private:
    Led leds[4];
    int num_pair_leds_to_turn_on;
    boolean is_odd_number;
  public:
    Face();
    void SetNumber(int number);
    void TurnOn();
    void TurnOff();
    void IsOn();
   protected:
    boolean isOn;
    void Turn(boolean turn);
};

Face::Face(){
  isOn = false;
  for( int numLed = 0; numLed < 4; numLed++ )
    leds[numLed].SetPin(numLed);
};

void Face::SetNumber(int n) {
 if(n == 1)
    num_pair_leds_to_turn_on = 0;
  else
    num_pair_leds_to_turn_on= n / 2;
  is_odd_number = n % 2 == 1; 
}

void Face::TurnOn() {
  Turn(true);
};

void Face::TurnOff() {
  Turn(false);
};

void Face::Turn(boolean turn) {
  if( isOn == turn )
    return;
  if( is_odd_number )
    turn ? leds[0].TurnOn() : leds[0].TurnOff();
  for( int numLed = 1; numLed <= num_pair_leds_to_turn_on;  numLed++ )
    turn ? leds[numLed].TurnOn() : leds[numLed].TurnOff();
  isOn = turn;
};

class Dice {
  private:
    Face faces[6];
  public:
    Dice();
    void TurnOnFace(int n);
    void TurnOffFace(int n);
    void TurnOnAllFaces();
    void Launch();
  protected:
    void TurnFace(int numFace, boolean turn);
};

Dice::Dice() {
  for( int numFace = 0; numFace < 6; numFace++ )
    faces[numFace].SetNumber(numFace+1);
};

void Dice::TurnOnFace(int number) {
  TurnFace(number,true);
};

void Dice::TurnOffFace(int number) {
 TurnFace(number,false);
};

void Dice::TurnFace(int numFace, boolean turn) {
  turn ? faces[numFace-1].TurnOn() : faces[numFace-1].TurnOff();
}

void Dice::Launch() {
  long num = random(1,7);
  TurnOnFace(num);
  delay(1000);
  TurnOffFace(num);
}

void Dice::TurnOnAllFaces() {
  for(int numFace = 0; numFace < 6; numFace++) {
   faces[numFace].TurnOn();
   faces[numFace].TurnOff();
   delay(1000); 
  }
}

Dice dice;

void setup() {}

void loop() {
  //dice.TurnOnFace(4);
  dice.Launch();
  //dice.BlinkAllFaces();
}

