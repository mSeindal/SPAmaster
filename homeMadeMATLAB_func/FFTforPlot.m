function [Frequencies, Amplitude, p] = FFTforPlot(data, fs, plotOnOff)
% FFTforPlot(data, Fs, p)
% 
% Returns:
%   Freqencies - used for the x-axis
%   Amplitude  - used for the y-axis
%   p          - is used for plot options if 'plotOnOff' is set to 'on'
% 
% data: the data you want to make a FFT of for plotting purpose 
% Fs:   sampling frequency [Hz]
% plotOnOff: 'on' = plot, 'off' = don't plot (default)
% 
% Ex ##############################
% [Frequencies, Amplitude, p] = FFTforPlot(data, fs, 'on')
% p
% p.LineWidth = 1.5;
% hold on % if more plots
%
% What it will plot:
% p = semilogx(Frequencies, mag2db(Amplitude)/20e-6);
% xlabel('Frequency [Hz]')
% ylabel('Amplitude')
% grid on


if nargin < 3
    plotOnOff = 'off';
end

L = length(data);
Y = fft(data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
Amplitude = P1;
Frequencies = fs*(0:(L/2))/L;


if strcmp('on', plotOnOff) || strcmp('On', plotOnOff) || strcmp('ON', plotOnOff)
    p = semilogx(Frequencies, mag2db(Amplitude)/20e-6);
    xlabel('Frequency [Hz]')
    ylabel('Amplitude')
    grid on
end

