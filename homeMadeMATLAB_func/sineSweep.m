function [sweep] = sineSweep(sweepTime, preDelay, postDelay, startFrq, endFrq, Fs, numbOfCh,type)
% [sweep] = sineSweep(sweepTime, preDelay, postDelay, startFrq, endFrq, Fs, numbOfCh, type)
% 
% If no type is chosen, the sweep is set to a logarithmic.
% The type can be linear if type = 'linear'.
%
% sweepTime = how long is your sweep in seconds
% preDelay  = time in seconds before sweep starts
% postDelay = time in seconds after the sweep ends
% startFrq  = the start frequency of the sweep in Hz
% endFrq    = the end frequency of the sweep in Hz
% Fs        = the sampling frequency in Hz
% numbOfCh  = How many channels should the sweep be (default = 1)

if nargin < 7
  numbOfCh = 1;
end
if nargin < 8
  type = 'log';
end

t = 0:1/(Fs):sweepTime - 1/Fs;
preDelay = Fs*preDelay;
postDelay = Fs*postDelay;
f0 = startFrq;
f1 = endFrq;
if strcmp(type,'linear') || strcmp(type,'Linear') || strcmp(type,'LINEAR')
    signal = chirp(t,f0,sweepTime,f1, 270);
else
    signal = chirp(t,f0,sweepTime,f1,'logarithmic', 270); % vi skriver 270(grader) da vi ville fasedreje signalet så vi starter på 0
end
sweep = [zeros(1,preDelay) signal zeros(1,postDelay)]';

if numbOfCh > 1
    sweepOG = sweep;
    for i = 1:numbOfCh
        sweep(:,i) = sweepOG;
    end
end

end

