classdef ForceDataCollection
    %ForceDataCollection collects data from force sensor for intertance
    %characterization.

    properties
        forceDataArr; % force data array
        forceTimeData; % time data array
        serialObj; % serial object for arduino serail communication
    end

    methods

        function obj = ForceDataCollection

            % set up data collection arrays
            obj.forceDataArr = [];
            obj.forceTimeData = [];

            % set up arduino communicatons
            % Serial port and baud rate from arduino script
            obj.serialObj = serialport("/dev/cu.usbmodem101", 115200);
            % Terminator is a line return
            configureTerminator(obj.serialObj, "CR/LF");
            % Clear serial data
            flush(obj.serialObj);

        end

        function obj = DataCollect(obj)

            % Collect Force Data
            obj.forceDataArr = ...
                [obj.forceDataArr, str2double(readline(obj.serialObj))];
            obj.forceTimeData = ...
                [obj.forceTimeData, str2double(readline(obj.serialObj))];

        end
    end
end