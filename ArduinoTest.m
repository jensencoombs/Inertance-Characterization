% Arduino MATLAB Test Script
clear, clc, close all

a = arduino('COM7', 'Uno', 'Libraries', 'advancedHX711/advanced_HX711');
Gain = 32;
Interrupt = false;

LoadCell = addon(a,'advancedHX711/advanced_HX711',...
           'Pins',{'D3','D2'},'Gain',128,'Interrupt',false);

%cal = addon(a, "advancedHX711/calibration", 'n', 100, 'known_weight', 80.07);

cal = calibration(100, 0.082)

Calibration = cal.tare(LoadCell)

i = true;

while i == true
    LoadCell.read_HX711 - Calibration
end

