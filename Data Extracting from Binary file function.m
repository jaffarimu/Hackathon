function [D] = get_data_from_bin_file_V2(filename, max_frame_number)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

fileID = fopen(filename);
Data_uint8 = fread(fileID, [4,inf], 'uint8=>uint8');
fclose(fileID);
[~, S2] = size(Data_uint8);

% Find sampling frequency
D.fs = swapbytes (typecast (Data_uint8(:,13), "single"))*1e3;

% Find Chirps per Frame 
D.Chirps_per_Frame = swapbytes (typecast (Data_uint8(:,17), "int32"));

% Find Samples per Chirp  
D.Samples_per_Chirp = swapbytes (typecast (Data_uint8(:,18), "int32"));

% Find Samples per Frame 
D.Samples_per_Frame = swapbytes (typecast (Data_uint8(:,19), "int32"));

% Find Bandwidth and range axis
D.Upper_RF_Frequency_kHz = swapbytes (typecast (Data_uint8(:,12), "single"));
D.Lower_RF_Frequency_kHz = swapbytes (typecast (Data_uint8(:,11), "single"));
D.Bandwidth_Hz = double((D.Upper_RF_Frequency_kHz-D.Lower_RF_Frequency_kHz)*1e3);
D.range_resolution_m = 3e8/(2*D.Bandwidth_Hz);
D.range_axis_m = double((0:D.Samples_per_Chirp/2-1).')*D.range_resolution_m;

% Find velocity axis
D.Pulse_Repetition_Time_sec = swapbytes (typecast (Data_uint8(:,21), "single"));
D.center_frequency_kHz = (D.Upper_RF_Frequency_kHz+D.Lower_RF_Frequency_kHz)/2;
D.velocity_resolution_mps = 3e8/(2*D.center_frequency_kHz*1e3*D.Pulse_Repetition_Time_sec*double(D.Chirps_per_Frame));
D.velocity_axis_mps = double((-D.Chirps_per_Frame/2:D.Chirps_per_Frame/2-1).')*D.velocity_resolution_mps;


% Find Number of antennas
D.Nfft_bf = 64; % Lenght of the beamforming fft
D.Num_Tx_Antennas = swapbytes (typecast (Data_uint8(:,4), "int32"));
D.Num_Rx_Antennas = swapbytes (typecast (Data_uint8(:,5), "int32"));
D.wavelength = 3e8 / (D.center_frequency_kHz*1e3);
D.angle_axis_au = asin((-1:2/D.Nfft_bf:1-1e-6))*180/pi;


D.Num_VA_Antennas = D.Num_Tx_Antennas * D.Num_Rx_Antennas;

D.data = zeros( D.Num_Tx_Antennas * D.Num_Rx_Antennas, D.Samples_per_Chirp, D.Chirps_per_Frame, max_frame_number);
file_idx = 24; %Begin of first frame
for iter_frame = 1:max_frame_number
    for iter_cpf = 1:D.Chirps_per_Frame
        for iter_tx = 1:D.Num_Tx_Antennas           
            for iter_spc = 1:D.Samples_per_Chirp
                for iter_rx = 1:D.Num_Rx_Antennas
                    D.data( (iter_tx-1)*D.Num_Rx_Antennas + iter_rx, iter_spc, iter_cpf, iter_frame) = swapbytes (typecast (Data_uint8(:,file_idx), "single"));
                    file_idx = file_idx + 1;
                end
            end
        end        
    end
    file_idx = file_idx + 1; % Jump over frame number of the next frame
    if file_idx>=S2
        break;
    end
end
D.Number_of_frame = iter_frame;



end

