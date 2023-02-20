classdef Optotune < handle
    
    % Optotune class is designed to control electro tunable lens from optotune.com
    % The script is written by R. Spesyvtsev from the Optical manipulation group (http://www.st-andrews.ac.uk/~photon/manipulation/)
    % Last modification by Zhengyi Yang
    %
    % constructor Optotune(com port), example lens = Optotune('COM9');
    % connect: lens = lens.Open();
    % set current to 100 mA:  lens = lens.setCurrent(100);
    % lens can be set to different modes: 
    % Current/Focal Power/Analog/Sinusoidal/Rectangular/Triangular
    % mode LowerCurrent/UpperCurrent/Frequency includes the parameters.
    
    % checkError will check the response if there is error and what error
    
    properties
        etl_port;
        port;
        status;
        response;
        
        firmware_type = NaN;
        serial_number = NaN;
        temperature = NaN;
        current = NaN; %% in mAmpers
        min_current = 0; % in mAmpers
        max_current = NaN; % in mAmpers
        min_current_lim = NaN; % in mAmpers
        max_current_lim = NaN; % in mAmpers
        calibration = 1;  % in mAmpers/micrometer
        focal_power = NaN;
        focal_power_limits = [NaN, NaN];
        
        mode = NaN;
        modeLowerCurrent = 0;
        modeUpperCurrent = 0;
        modeFrequency = 1;
        
        analogInput = 0;
        max_bin = 0;
        time_pause = 0.3;
        time_laps = 0.01;
        last_time_laps;
        
        serial_mode = 'sync';
        error = false;
    end
    
    methods
        function lens=Optotune(port)
            if (nargin<1)
                lens.port='/dev/tty.usbmodem41';
            else
                lens.port = port;
            end
        end
        
        function lens = Open(lens)
            % Setting up initial parameters for the com port
            lens.etl_port = serial(lens.port);
            lens.etl_port.Baudrate=115200;
            lens.etl_port.StopBits=1;
            lens.etl_port.Parity='none';
            
            fopen(lens.etl_port);
            lens.status = lens.etl_port.Status;   %%% checking if initialization was completed the status should be "open"
            
            % Initialize communication
            fprintf(lens.etl_port, 'Start'); %%% initiating the communication
            lens.last_time_laps = checkStatus(lens);
            %lens.etl_port.BytesAvailable;  %%% checking number of bytes in the response
            fscanf(lens.etl_port);  %%% reading out the response which should read "Ready"
            if lens.etl_port.BytesAvailable
                fread(lens.etl_port,lens.etl_port.BytesAvailable);
            end
            
            
            lens = lens.getFirmwareType();
            lens = lens.getSerialNumber();
            
            %get initial information about UpperCurrentLimte and MaxBin;
            lens = lens.getUpperLimitA();
            lens = lens.getCurrent();
            lens = lens.getLowerSoftCurrentLimit();
            lens = lens.getUpperSoftCurrentLimit();
            %Get initial parameters
            lens = lens.getMode();
            lens = lens.getModeFrequency();
            lens = lens.getModeLowerCurrent();
            lens = lens.getModeUpperCurrent();
            lens = lens.getTemperature();
        end
        
        function lens = getFirmwareType(lens)
            command = append_crc('H'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            crc_check = append_crc(lens.response(1:end-4));
            if ~all(lens.response(end-4:end-2) == crc_check(end-2:end))
                warning('getFirmwareType CRC mismatch');
            else
                lens.firmware_type = char(lens.response(2));
            end
        end
        
        function lens = getSerialNumber(lens)
            command = append_crc('X'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port, lens.etl_port.BytesAvailable);
            crc_check = append_crc(lens.response(1:end-4));
            if ~all(lens.response(end-4:end-2) == crc_check(end-2:end))
                warning('getSerialNumber CRC mismatch');
            else
                lens.serial_number = convertCharsToStrings(char(lens.response(2:9)));
            end
        end
        
        function lens = getTemperature(lens)
            command = append_crc('TA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            x = lens.response(4)*(hex2dec('ff')+1) + lens.response(5);
            lens.temperature = x*0.0625;
        end
        
        %% Current (in mA) %%
        function lens = getCurrent(lens)
            command = append_crc(['Ar'-0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            lens.current = bitshift(lens.response(2), 8) + lens.response(3);
            lens.current = lens.current * lens.max_current/4095;
        end
        
        function setCurrent(lens, ci)
            % Set current in mA via ci variable
            if ~strcmp(lens.mode, 'Current')
                lens = lens.modeCurrent();
            end
            set_i = round(ci*(4095/lens.max_current));
            LB = mod(set_i,256);
            HB = mod((set_i-LB)/256, 256);
            command = append_crc(['Aw'-0 HB LB]);
            fwrite(lens.etl_port, command, lens.serial_mode);
        end
        
        %% Focal power (in D) %%
        function lens = getFocalPower(lens)
            command = append_crc(['PrDA'-0 0 0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port, lens.etl_port.BytesAvailable);
            dec2hex(lens.response)
            lens.focal_power = bitshift(lens.response(3), 8) + lens.response(4);
            if (lens.firmware_type == 'A')
                lens.focal_power = lens.focal_power/200-5;
            elseif any(lens.firmware_type == ['B', 'C', 'D', 'E', 'F', 'H'])
                lens.focal_power = lens.focal_power/200;
            end
        end
        
        function setFocalPower(lens, di)
            % Set focal power in D via di variable
            if ~strcmp(lens.mode, 'FocalPower')
                lens = lens.modeFocalPower();
            end
            if di < lens.focal_power_limits(1)
                warning('setFocalPower to value under minimum (requested: %f, minimum: %f)', di, lens.focal_power_limits(1));
                di = lens.focal_power_limits(1);
            elseif di > lens.focal_power_limits(2)
                warning('setFocalPower to value above maximum (requested: %f, maximum: %f)', di, lens.focal_power_limits(2));
                di = lens.focal_power_limits(2);
            end
            lens.focal_power = di;
            if (lens.firmware_type == 'A')
                set_d = round((di+5)*200);
            elseif any(lens.firmware_type == ['B', 'C', 'D', 'E', 'F', 'H'])
                set_d = round(di*200);
            end
            LB = mod(set_d, 256);
            HB = mod((set_d-LB)/256, 256);
            command = append_crc(['PwDA'-0 HB LB 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
        end
        
        %% Temperature limits for operation in focal power mode
        % Values in degrees celsius
        function lens = getTemperatureLimits(lens, data_in)
            if (nargin < 2) || isempty(data_in)
                command = append_crc(['PrTA'-0 0 0 0 0]);
                fwrite(lens.etl_port, command, lens.serial_mode);
                lens.last_time_laps = checkStatus(lens);
                lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            else
                lens.response = data_in;
            end
            % Has issues with newer lens firmware
            lens.focal_power_limits(2) = bitshift(lens.response(4), 8) + lens.response(5);
            lens.focal_power_limits(1) = bitshift(lens.response(6), 8) + lens.response(7);
            if (lens.firmware_type == 'A')
                lens.focal_power_limits(2) = lens.focal_power_limits(2)/200-5;
                lens.focal_power_limits(1) = lens.focal_power_limits(1)/200-5;
            elseif any(lens.firmware_type == ['B', 'C', 'D', 'E', 'F', 'H'])
                lens.focal_power_limits(2) = lens.focal_power_limits(2)/200;
                lens.focal_power_limits(1) = lens.focal_power_limits(1)/200;
            end
        end
        
        function lens = setTemperatureLimits(lens, temps)
            temp_high = temps(2)*16;
            temp_low = temps(1)*16;
            LBH = mod(temp_high, 256);
            HBH = mod((temp_high-LBH)/256, 256);
            LBL = mod(temp_low, 256);
            HBL = mod((temp_low-LBL)/256, 256);
            command = append_crc(['PwTA'-0 HBH LBH HBL LBL]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port, lens.etl_port.BytesAvailable);
            lens = getTemperatureLimits(lens, lens.response);
        end
        
        %% Current limits %%
        function lens = getLowerSoftCurrentLimit(lens)
            command = append_crc(['CrLA'-0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            lens.min_current_lim = bitshift(lens.response(4),8) + lens.response(5);
            lens.min_current_lim = lens.min_current_lim * (lens.max_current/4095);
        end
        
        function lens = getUpperSoftCurrentLimit(lens)
            command = append_crc(['CrUA'-0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            lens.max_bin = lens.response(4)*(hex2dec('ff')+1) + lens.response(5)+1;
            lens.max_current_lim = bitshift(lens.response(4),8) + lens.response(5);
            lens.max_current_lim = lens.max_current_lim * (lens.max_current/4095);
        end
        
        function lens = getUpperLimitA(lens)
            command = append_crc(['CrMA'-0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            lens.max_current = lens.response(4)*(hex2dec('ff')+1) + lens.response(5);  %% software current limit usually 292.84 mA;
            lens.max_current = lens.max_current / 100; %% reads current in mili ampers
        end
        
        %% get the current mode the lens is running at
        function lens = getMode(lens)
            command = append_crc('MMA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            checkError(lens);
            switch lens.response(4)
                case 1
                    lens.mode = 'Current';
                case 2
                    lens.mode = 'Sinusoidal';
                case 3
                    lens.mode = 'Triangular';
                case 4
                    lens.mode = 'Retangular';
                case 5
                    lens.mode = 'FocalPower';
                case 6
                    lens.mode = 'Analog';
                case 7
                    lens.mode = 'PositionControlled';
            end
            logMessage(sprintf('Lens is driven in %s mode', lens.mode));
        end
        
        %% set the lens to different mode
        function lens = modeCurrent(lens)
            command = append_crc('MwDA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MDA')
                logMessage('Lens set to Current Mode succesfully');
                lens.mode = 'Current';
            else
                checkError(lens);
            end
        end
        
        function lens = modeSinusoidal(lens)
            command = append_crc('MwSA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MSA')
                logMessage('Lens set to Sinusoidal Signal Mode succesfully');
                lens.mode = 'Sinusoidal';
            else
                checkError(lens);
            end
            lens = lens.setModeFrequency(lens.modeFrequency);
            lens = lens.setModeLowerCurrent(lens.modeLowerCurrent);
            lens = lens.setModeUpperCurrent(lens.modeUpperCurrent);
        end
        
        function lens = modeTriangular(lens)
            command = append_crc('MwTA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MTA')
                logMessage('Lens set to Triangular Signal Mode succesfully');
                lens.mode = 'Triangular';
            else
                checkError(lens);
            end
            lens = lens.setModeFrequency(lens.modeFrequency);
            lens = lens.setModeLowerCurrent(lens.modeLowerCurrent);
            lens = lens.setModeUpperCurrent(lens.modeUpperCurrent);
        end
        
        function lens = modeRectangular(lens)
            command = append_crc('MwQA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MQA')
                logMessage('Lens set to Rectangular Signal Mode succesfully');
                lens.mode = 'Retangular';
            else
                checkError(lens);
            end
            lens = lens.setModeFrequency(lens.modeFrequency);
            lens = lens.setModeLowerCurrent(lens.modeLowerCurrent);
            lens = lens.setModeUpperCurrent(lens.modeUpperCurrent);
        end
        
        function lens = modeFocalPower(lens)
            % Set some default temperature limits if not already set (in C)
            if isnan(lens.focal_power_limits(1))
                lens = lens.setTemperatureLimits([20, 45]);
            end
            
            command = append_crc('MwCA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MCA')
                logMessage('Lens set to Focal Power Mode succesfully');
                lens.mode = 'FocalPower';
            else
                checkError(lens);
            end
        end
        
        function lens = modeAnalog(lens)
            command = append_crc('MwAA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:3))'), 'MAA')
                logMessage('Lens set to Analog Mode succesfully');
                lens.mode = 'Analog';
            else
                checkError(lens);
            end
        end
        
        %% set parameters for the mode controlling
        
        % set signal generator upper current limit
        function lens = setModeUpperCurrent(lens,ci)
            if ci > lens.max_current || ci < 0
                logMessage('The current should be between 0 and %.2f mA', lens.max_current);
                ci = lens.max_current;
            else
                if ci < lens.modeLowerCurrent
                    lens = lens.setModeLowerCurrent(ci);
                end
            end
            set_i = (floor(ci*(lens.max_bin+1) / lens.max_current));
            LB = mod(set_i,256); %% low byte
            HB = (set_i-LB)/256; %% high byte
            command = append_crc(['PwUA'-0 HB LB 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            checkError(lens);
            if lens.error == true
                logMessage('Error occurred when setting modeUpperCurrent');
            end
            
            getModeUpperCurrent(lens);
        end
        
        % get signal generator upper current limit
        function lens = getModeUpperCurrent(lens)
            command = append_crc(['PrUA'-0 0 0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
             if strcmp(cellstr(char(lens.response(1:4))'), 'MPAU')
                lens.modeUpperCurrent = (lens.response(5)*(hex2dec('ff')+1) + lens.response(6))*lens.max_current/lens.max_bin;
            else
                checkError(lens);
                if lens.error == true
                    logMessage('Error occurred when getting modeUpperCurrent');
                end
            end
        end
        
        % set signal generator lower current limit
        function lens = setModeLowerCurrent(lens,ci)
            if ci > lens.max_current || ci < 0
                logMessage('The current should be between 0 and %.2f mA', lens.max_current);
                ci = 0;
            else
                if ci > lens.modeUpperCurrent
                    lens = lens.setModeUpperCurrent(ci);
                end
            end
            set_i = (floor(ci*(lens.max_bin+1) / lens.max_current));
            LB = mod(set_i,256); %% low byte
            HB = (set_i-LB)/256; %% high byte
            command = append_crc(['PwLA'-0 HB LB 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            checkError(lens);
            if lens.error == true
                logMessage('Error occurred when setting modeLowerCurrent');
            end
                       
            getModeLowerCurrent(lens);
        end
        
        % get signal generator lower current limit
        function lens = getModeLowerCurrent(lens)
            command = append_crc(['PrLA'-0 0 0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:4))'), 'MPAL')
                lens.modeLowerCurrent = (lens.response(5)*(hex2dec('ff')+1) + lens.response(6))*lens.max_current/lens.max_bin;  %% software current limit usually 292.84 mA;
            else
                checkError(lens);
                if lens.error == true
                    logMessage('Error occurred when getting modeLowerCurrent');
                end
            end
        end
        
        % set signal generator lower current limit
        function lens = setModeFrequency(lens,ci)
            if ci < 0.1
                logMessage('The minimum frequency is 0.1 Hz!');
                ci = 0.1;
            end
            set_i = ci*1000;
            B4 = mod(set_i,256); %% 4th byte
            B3 = mod((set_i-B4)/256,256); %% third byte
            B2 = mod((set_i-B3*256-B4),256); %% second byte
            B1 = mod((set_i-B2*2^16-B3*256-B4),256); %% first byte
            command = append_crc(['PwFA'-0 B1 B2 B3 B4]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            checkError(lens);
            if lens.error == true
                logMessage('Error occurred when setting modeFrequency');
            end
            
            getModeFrequency(lens);
        end
        
        % get signal generator lower current limit
        function lens = getModeFrequency(lens)
            command = append_crc(['PrFA'-0 0 0 0 0]);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            if strcmp(cellstr(char(lens.response(1:4))'), 'MPAF')
                lens.modeFrequency = (lens.response(5) * 2^24 + lens.response(6) * 2^16 + lens.response(7) * 2^8 + lens.response(8))/1000;  %% software current limit usually 292.84 mA;
            else
                checkError(lens);
                if lens.error == true
                    logMessage('Error occurred when getting modeFrequency');
                end
            end
        end
        
           
        function lens = getAnalogInput(lens)
            command = append_crc('GAA'-0);
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            lens.analogInput = lens.response(4)*(hex2dec('ff')+1) + lens.response(5);
        end
        
        function lens = testError(lens)
            command = 'St4rt';
            fwrite(lens.etl_port, command, lens.serial_mode);
            lens.last_time_laps = checkStatus(lens);
            lens.response = fread(lens.etl_port,lens.etl_port.BytesAvailable);
            checkError(lens);
        end
        
        %%  Closing the port when finished using it %%%%%%%%%%%%
        function lens = Close(lens)
            lens = lens.modeCurrent();
            lens.setCurrent(0);
            while ~strcmp(lens.etl_port.TransferStatus, 'idle')
            end
            fclose(lens.etl_port);
            delete(lens.etl_port);
            clear lens.etl_port
            
            lens.status = 'closed';
            lens.response = 'Shut down';
            
        end
        
        function tElapsed = checkStatus(lens)
            bts = lens.etl_port.BytesAvailable;  %%% checking number of bytes in the response
            tStart = tic;
            tElapsed = 0;
            while (bts == 0) || (tElapsed > 5)
                bts = lens.etl_port.BytesAvailable;  %%% checking number of bytes in the response
                pause(lens.time_laps);
                tElapsed = toc(tStart);
            end
        end
        
        %Check if there is error message and identify what it is, display.
        function checkError(lens)
            lens.error = false;
            if char(lens.response(1)) == 'E'
                switch lens.response(2)
                    case 1
                        logMessage('CRC failed.');
                    case 2
                        logMessage('Command not available in firmware type.');
                    case 3
                        logMessage('Command not regongnized.');
                    case 4
                        logMessage('Lens is not compatible with firmware.');
                        
                end
                lens.error = true;
            end
        end
    end
end
