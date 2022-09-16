function [output, error] = adaptfilt1(d, x, M, beta)

% d .... reference signal
% x .... input signal to adaptive filter
% M .... filter order
% beta.. adaptation rate of adaptive algorithm

w=zeros(1,M+1); % initialise filter coefficients

N = min([length(d) length(x)]);
input = zeros(1,N); % initialise delay line of filter
output=zeros(1,N);  % initialise output vector
error= zeros(1,N);  % initialise error vector

for i=1:N
    input(1)=x(i);
    y=0;
    for k=1:M+1
        y=y+w(k)*input(k);  %calculate filter output
    end
    e=d(i)-y;               %calculate error signal
    
    for k=(M+1):(-1):1
        w(k)=w(k)+beta*e*input(k);
        if k > 1
            input(k)=input(k-1);
        end
    end
    output(i)=y;
    error(i)=e;
end