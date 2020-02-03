function [ImpulseResponse, window] = sweptSine(Recorded_signal, OG_signal, fade_percent)
% [ImpulseResponse, window] = sweptSine(Recorded_signal, OG_signal, fade_percent)
% 
% A function that use the Swept Sine Method to create an impulse response. 
% It require a recorded signal and the original signal, and the output the
% impuls response.
% 
% Recorded_signal:    is the recorded signal as a vector
% OG_signal:          is the original signal played in the system as a vector
% fade_percent:       will fade out the impulse response with a shiftet 
%                     Hamming-window so the impluse will end with a zero.
%                     The value is given in percent. Default, if no input
%                     fade_percent = 10 -> 10%
%
% It is also possible to get the window vector: [imp, wind] = sweptSine()
%GIT TEST2 - PRØVER IGEN

if nargin < 3
  fade_percent = 10;
end


extraZeros = length(Recorded_signal)-length(OG_signal); % hack?

Recorded_signal = Recorded_signal(1:end-extraZeros);
Recorded_signal = [Recorded_signal' zeros(length(Recorded_signal),1)']';

OGsignal = [OG_signal' zeros(length(OG_signal),1)']';

fftX = fft(OGsignal);
fftY = fft(Recorded_signal);
RTFxy = fftY./fftX;
RIR = ifft(RTFxy);
winRIR = RIR(1:(length(RIR)/2),1);


fade_percent = fade_percent/100;
N = length(winRIR);
w = hann(N*2*fade_percent);
window = [ones(1,N-N*fade_percent),w(N*fade_percent +1:end)'];

ImpulseResponse = winRIR.*window';

end

