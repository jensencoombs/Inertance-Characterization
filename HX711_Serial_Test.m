% Read HX711 Serial Data Test

serialObj = serialport("COM7", 115200); % Serial port and baud rate from arduino script
configureTerminator(serialObj, "CR/LF"); % Terminator is a line return
flush(serialObj); % Clear serial data

% Collect i number of data points
for i = 1:100
    data(i) = readline(serialObj); % Read arduino serial data
    x(i) = i;
end

data_Num = str2double(data); % Convert from string to double

plot(x, data_Num) % Plot of force data
title('Load Cell Data')
xlabel('Sample Number')
ylabel('Force [N]')
