classdef AccelerationDataCollection
    % AccelerationDataCollection Collects acceleration data from
    % accelerometer from daq

    properties
        accelDataArray
        accelTimeArray
        d
        ch

    end

    methods
        function obj = AccelerationDataCollection()
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.accelDataArray = [0];
            obj.accelTimeArray = [0];

            obj.d = daq("ni"); % Create daq object
            obj.ch = addinput(obj.d, "cDAQ1Mod1", "ai0", "Accelerometer"); % Add input for accelerometer
            obj.d.Rate = 2048; % Data collection rate of accelerometer
            obj.ch.Sensitivity = 0.00999; % See accelerometer paper in box
        end

        function obj = AccelDataCollect(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
           data = read(obj.d, seconds(0.001));
           accelDataArray = [obj.accelDataArray; data.cDAQ1Mod1_ai0];
           accelTimeArray = [obj.accelTimeArray; obj.accelTimeArray(end) + data.Time ];
        end
    end
end