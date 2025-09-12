  float Time_Zero = millis();

#include <HX711_ADC.h> // Library for hx711 board
#if defined(ESP8266)|| defined(ESP32) || defined(AVR)
#include <EEPROM.h>
#endif

//pins:
const int HX711_dout = 3; //mcu > HX711 dout pin
const int HX711_sck = 2; //mcu > HX711 sck pin

//HX711 constructor:
HX711_ADC LoadCell(HX711_dout, HX711_sck);

const int calVal_eepromAdress = 0;
unsigned long t = 0;
unsigned long t_0 = 0;

void setup() {
  // put your setup code here, to run once:
Serial.begin(115200);
LoadCell.begin();
LoadCell.tare();

// Get calibration factor from Serial_Plotter script
LoadCell.setCalFactor(9308.97);
}

void loop() {
  // put your main code here, to run repeatedly:
  static boolean newDataReady = 0;
  const int serialPrintInterval = 0;

  if (LoadCell.update()) newDataReady = true;

  if (newDataReady) {
    if (millis() > t + serialPrintInterval) {
    float force = LoadCell.getData(); // Force in Newtons
    Serial.println(force);
    Serial.print(",");
    Serial.println((millis() - Time_Zero) / 1000);

    newDataReady = 0;
    t = millis(); 
    }
  }

}
