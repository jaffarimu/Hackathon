%% 
% Eliminate the affects of different frequencies getting mixed by the radar 
% incoming signal at the reciever's end Regressive  Application for modelled Signal

% The data is generally stored into the binay file by radar fusion GUI
% that data can be extracted into the matlab by using function
% "Data Extracting from Binary file function.m" also attached

N=300; % That defines the frame rate too while starying the data acquisition in Fusion GUI
% The radar uses 60 Ghz frequency to operate so 

% This defines the range of real time radar usage frequencies 

f1=6.0e+10; % 60 GHz
f2=6.1e+10;
f3=6.2e+10;
f4=6.3e+10;
f5=5.9e+10;
fs=8000;

% Variables frequencies at which original signal is getting mixed by the incoming signal

f6=7.0e+10; 
f7=5.8e+10;
f8=6.8e+10;

n=0:1:N-1;

d=sin(2*pi*f1*n/fs)+sin(2*pi*f7*n/fs)+tan(2*pi*f8*n/fs); % AS the RF Waves are the function of sine waves with a specific frequencies

x=cos(2*pi*f6*n/fs);

M=30; % Selected as the optimum filter coefficients and can be changed according to the hardware available and requirement

beta=0.04; 
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
title("modelled signal according to the variable frequencies 'x'");
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
% 
%