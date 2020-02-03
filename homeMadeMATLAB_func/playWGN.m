function [WGN] = playWGN(noiseTime, Fs, preDelay, postDelay)
% [WGN] = playWGN(noiseTime, Fs, preDelay, postDelay)
% 
% A function that plays WGN in a given time.
%
% noiseTime = how long is your noise in seconds
% preDelay  = time in seconds before noise starts
% postDelay = time in seconds after the noise ends
% Fs        = the sampling frequency in Hz
%

if nargin < 3
  preDelay = 0;
end

if nargin < 4
  postDelay = 0;
end


signal = rand(1, Fs*noiseTime).*2-1;
WGN = [zeros(1,Fs*preDelay) signal zeros(1,Fs*postDelay)];
end

