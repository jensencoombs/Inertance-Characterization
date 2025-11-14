#include <Adafruit_NAU7802.h>

Adafruit_NAU7802 nau;

void setup() {
  Serial.begin(115200);

  if (!nau.begin()) {
    Serial.println("Failed to find NAU7802");
    while (1) delay(10);  // Don't proceed.
  }

  nau.setLDO(NAU7802_4V5);  // set voltage for amplifier (4.5 v)

  nau.setGain(NAU7802_GAIN_128);  // set gain for amplifier

  nau.setRate(NAU7802_RATE_320SPS);  // set sampling rate (320 hz)

  for (uint8_t i = 0; i < 10; i++) {
    while (!nau.available()) delay(1);
    nau.read();
  }
}



void loop() {
  while (!nau.available()) {
    delay(1);
  }
  int32_t val = nau.read();
  Serial.println(val);  // just the value, one per line
}
