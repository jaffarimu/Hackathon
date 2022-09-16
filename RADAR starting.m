%% 
% Task is to reduce/eliminate the affects of different frequencies getting mixed 
% by the radar incoming signal at the reciever's end Basic Application for modelled 
% Signal

% The data is generally stored into the binay file by radar fusion GUI
% that data can be extracted into the matlab by using function
% "Data Extracting from Binary file function.m" also attached

N=300; % That defines the frame rate too while starying the data acquisition in Fusion GUI
% The radar uses 60 Ghz frequency to operate so 

f1=6.0e+10; % 60 GHz

f2=7.0e+10; % 70 GHZ is supposed the frequency that is getting mixed by the incoming signal
fs=8000;
n=0:1:N-1;

d=sin(2*pi*f1*n/fs)+sin(2*pi*f2*n/fs)+tan(2*pi*f2*n/fs); % AS the RF Waves are the function of sine waves with a specific frequencies

x=cos(2*pi*f2*n/fs);

M=30; % Selected as the optimum filter coefficients and can be changed according to the hardware available and requirement

beta=0.04; % The adaption rate defines how regressive filter should act and affects the accuray of system which will be explained in presentation
% Input parameters of adaptfilt1.m: Reference Signal/Desired Signal (d), Input Signal (x), Filter Order (M), Adaption Rate (ß)
% Output parameters of adaptfilt1.m: Output Signal (Y), Error signal (e)

[y, e] = adaptfilt1(d, x, M, beta);

subplot(4,1,1)
plot(d,'r'); 
title("Input corrrupted signal need to be cleaned 'd'");
xlabel("");
ylabel("");
subplot(4,1,2)
plot(x,'b'); 
title("modelled signal according to the 70 Ghz 'x'");
xlabel("");
ylabel("x[n]");
subplot(4,1,3)
plot(y); 
title("modified Signal getting modified just after the Filter 'y'");
xlabel("");
ylabel("y[n]");
subplot(4,1,4)
plot(e,'g'); 
title("Final Signal obtained after the elmination of mixed incomings");
xlabel("");
ylabel("e[n]");

%% 
% 
% 
%