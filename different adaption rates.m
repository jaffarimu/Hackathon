%% 
% Monitering the affacts of different adaption rates

N=300; % That defines the frame rate too while starying the data acquisition in Fusion GUI
% The radar uses 60 Ghz frequency to operate so 

f1=6.0e+10; % 60 GHz

f2=7.0e+10; % 70 GHZ is supposed the frequency that is getting mixed by the incoming signal
fs=8000;
n=0:1:N-1;

d=sin(2*pi*f1*n/fs)+sin(2*pi*f2*n/fs)+tan(2*pi*f2*n/fs); % AS the RF Waves are the function of sine waves with a specific frequencies

x=cos(2*pi*f2*n/fs);

M=30; % Selected as the optimum filter coefficients and can be changed according to the hardware available and requirement

beta=0.07; % Previously 0.5
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
title("Final Signal with higher adaption rate ");
xlabel("");
ylabel("e[n]");