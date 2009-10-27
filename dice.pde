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
    int par_leds_to_turn_on;
    boolean is_turn_on_unit_lend;
  public:
    Face();
    void SetNumber(int number);
    void TurnOn();
    void TurnOff();
    boolean isOn;
};

Face::Face(){
  isOn = false;
  for( int numLed = 0; numLed < 4; numLed++ )
    leds[numLed].SetPin(numLed);
};

void Face::SetNumber(int n) {
 if(n == 1)
    par_leds_to_turn_on = 0;
  else
    par_leds_to_turn_on= n / 2;
  is_turn_on_unit_lend = n % 2 == 1; 
}

void Face::TurnOn() {
  if( isOn )
    return;
  if( is_turn_on_unit_lend )
    leds[0].TurnOn();
  for( int numLed = 1; numLed <= par_leds_to_turn_on;  numLed++ )
    leds[numLed].TurnOn();
  isOn = true;
};

void Face::TurnOff() {
  if( !isOn )
    return;
  if( is_turn_on_unit_lend )
    leds[0].TurnOff();
  for( int numLed = 1; numLed <= par_leds_to_turn_on;  numLed++ )
    leds[numLed].TurnOff();
  isOn = false;
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
};

Dice::Dice() {
  for( int numFace = 0; numFace < 6; numFace++ )
    faces[numFace].SetNumber(numFace+1);
};

void Dice::TurnOnFace(int number) {
  faces[number-1].TurnOn();
};

void Dice::TurnOffFace(int number) {
  faces[number-1].TurnOff();
};

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

