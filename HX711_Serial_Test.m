% Read HX711 Serial Data Test

serialObj = serialport("COM7", 115200); % Serial port and baud rate from arduino script
configureTerminator(serialObj, "CR/LF"); % Terminator is a line return
flush(serialObj); % Clear serial data

% Collect i number of data points
for i = 1:100
data(i) = readline(serialObj) % Read arduino serial data
end

%%
data_Num = str2double(data) % Convert from string to double

x = 1:100;

plot(x, data_Num)