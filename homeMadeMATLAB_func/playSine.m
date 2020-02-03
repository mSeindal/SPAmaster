function [sinewave] = playSine(sineFrq, sineTime, Fs, preDelay, postDelay)
% [sinewave] = playSine(sineFrq, sineTime, Fs, preDelay, postDelay)
% 
% A function that plays WGN in a given time.
% 
% sineFrq   = the frequency of the sine wave
% sineTime  = how long is your sine wave in seconds
% Fs        = the sampling frequency in Hz
% preDelay  = time in seconds before sine starts
% postDelay = time in seconds after the sine ends
% 
%

if nargin < 4
  preDelay = 0;
end

if nargin < 5
  postDelay = 0;
end

t = 0:1/Fs:sineTime - 1/Fs;
signal = sin(2*pi*sineFrq*t);


sinewave = [zeros(1,Fs*preDelay) signal zeros(1,Fs*postDelay)];



end

