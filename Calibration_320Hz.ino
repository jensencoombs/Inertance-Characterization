#include <Adafruit_NAU7802.h>
Adafruit_NAU7802 nau;

void setup() {
  Serial.begin(115200);

  if (!nau.begin()) {
    Serial.println("Failed to find NAU7802");
    while (1) delay(10);
  }

  nau.setLDO(NAU7802_4V5);
  nau.setGain(NAU7802_GAIN_128);
  nau.setRate(NAU7802_RATE_320SPS);

  // Throw away startup samples
  for (uint8_t i = 0; i < 10; i++) {
    while (!nau.available()) delay(1);
    nau.read();
  }
}

float averageSamples(int count, float offset = 0) {
  double total = 0.0;

  for (int i = 0; i < count; i++) {
    while (!nau.available()) delay(1);
    int32_t raw = nau.read();
    total += (raw - offset);
  }

  return total / count;
}

void loop() {

  Serial.println("Taring...");
  float tareValue = averageSamples(5000);   // average of raw readings
  Serial.print("Tare = ");
  Serial.println(tareValue);

  delay(1000);

  Serial.println("Measuring scale...");
  delay(7000);   // time for you to place weight

  float netAvg = averageSamples(5000, tareValue);  // tare-corrected average

  // Your calibration factor
  float scaleFactor = netAvg / 0.08007;

  Serial.print("Scale factor = ");
  Serial.println(scaleFactor);

  // Take one live reading
  while (!nau.available()) delay(1);
  float live = (nau.read() - tareValue) / scaleFactor;

  Serial.print("Reading = ");
  Serial.println(live);
}
