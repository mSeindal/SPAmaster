function [OctFilteredSigal, centerFrqVec, p] = octBandAnalyzer(input, Fs, octaveBand, FilterOrder, showFrq, plotOnOff, BarOrStairs)
% [OctFilteredSigal, centerFrqVec, p] = octBandAnalyzer(input, Fs, octaveBand, FilterOrder, showFrq, BarOrStairs) 
%
% A function that filter an input signal in octave bands. Choose
% between different octave bands and different filter orders.
%
% The centerFrqVec output the nominal center frequencies for a given octave
% band from 16 Hz to the highest center frequency with a given sampling
% frequency (44100 or 48000 Hz) and octave band (1 octave or 1/3 octave), 
% it is possible to go lower. The parameter 'p' is used for plot options
% if 'plotOnOff' is set to 'on'.
%
% input       = the signal as a vector
% Fs          = sampling frequency
% octaveBand  = the octave filter you want to use, fx.
%               '1 octave'
%               '1/3 octave'
%               (if this parameter is not set, default is: 1/3 octave)
% FilterOrder = The order of the filter
%               (if this parameter is not set, default is: 6)
% showFrq     = which frequencies you want to display. Input as a vector:
%               e.g. [40, 5000] = [start frq., end frq.]
%               (if this parameter is not set, default is: [16, 20000])
% plotOnOff   = 'on' = plotting, 'off' = don't plotting
%               (if this parameter is not set, default is: 'off')
% BarOrStairs = 'stairs' = making a stair plot, 'bar' = making a bar plot
%               (if this parameter is not set, default is: 'stair')
%
% EX ###########################
% data = data vector
% [oct, cF, p]=octBandAnalyzer(data, 48000, '1/3 octave', 12, [31.5 20000], 'on');
% p
% p.LineWidth = 1.5;
% hold on % if more plots
%
% EX ########################### 
%
% [oct, cF]= octBandAnalyzer(data, Fs, '1/3 octave', 12);
% 
% plotThis = 10*log10((rms(oct).^2)/(20e-6)^2);
% plotThis(end + 1) = plotThis(end);
% stairs(0:length(cF), plotThis)
% xticks(0.5:length(cF))
% xticklabels(cF)
% xtickangle(45)
% xlabel('Frequency Bands [Hz]')
% ylabel('SPL [dB]')
%
if nargin < 3
    octaveBand = '1/3 octave';
end
if nargin < 4
    FilterOrder = 6;
end

if nargin < 5
    showFrq = [16, 20000];
end

if nargin < 6
    plotOnOff = 'off';
end

if nargin < 7
    BarOrStairs = 'stairs';
end

if strcmp(octaveBand, '1/3 octave') && Fs == 48000
    centerFrqVec = [4 5 6.3 8 10 12.5 ...
                    16 20 25 31.5 40 50 63 80 100 125 160 ...
                    200 250 315 400 500 630 800 1000 1250 ...
                    1600 2000 2500 3150 4000 5000 6300 ...
                    8000 10000 12500 16000 20000];
end
if strcmp(octaveBand, '1/3 octave') && Fs == 44100
    centerFrqVec = [4 5 6.3 8 10 12.5 ...
                    16 20 25 31.5 40 50 63 80 100 125 160 ...
                    200 250 315 400 500 630 800 1000 1250 ...
                    1600 2000 2500 3150 4000 5000 6300 ...
                    8000 10000 12500 16000];
end
if strcmp(octaveBand, '1 octave') && Fs == 48000
    centerFrqVec = [16 31.5 63 125 ...
                    250 500 1000 ...
                    2000 4000 ...
                    8000 16000];
end
if strcmp(octaveBand, '1 octave') && Fs == 48000
    centerFrqVec = [8 16 31.5 63 125 ...
                    250 500 1000 ...
                    2000 4000 ...
                    8000 16000];
end
if strcmp(octaveBand, '1 octave') && Fs == 44100
    centerFrqVec = [8 16 31.5 63 125 ...
                    250 500 1000 ...
                    2000 4000 ...
                    8000];
end

B = centerFrqVec >= showFrq(1);
centerFrqVec = centerFrqVec(B);
C = centerFrqVec <= showFrq(2);
centerFrqVec = centerFrqVec(C);

octFilt = octaveFilter(1000, octaveBand, 'SampleRate', Fs);
cF = getANSICenterFrequencies(octFilt);
% round(cF)
% ------------------------HACK---------------------------------------------
if showFrq(1) == 80 
    showFrq(1) = 79;
elseif showFrq(2) == 80
    showFrq(2) = 79;
end
if showFrq(1) == 160 
    showFrq(1) = 158;
elseif showFrq(2) == 160
    showFrq(2) = 158;
end
if showFrq(1) == 400 
    showFrq(1) = 398;
elseif showFrq(2) == 400
    showFrq(2) = 398;
end
if showFrq(1) == 800 
    showFrq(1) = 794;
elseif showFrq(2) == 800
    showFrq(2) = 794;
end
if showFrq(1) == 1600 
    showFrq(1) = 1585;
elseif showFrq(2) == 1600
    showFrq(2) = 1585;
end
if showFrq(1) == 2000 
    showFrq(1) = 1995;
elseif showFrq(2) == 2000
    showFrq(2) = 1995;
end
if showFrq(1) == 4000 
    showFrq(1) = 3981;
elseif showFrq(2) == 4000
    showFrq(2) = 3981;
end
if showFrq(1) == 8000 
    showFrq(1) = 7943;
elseif showFrq(2) == 8000
    showFrq(2) = 7943;
end
if showFrq(1) == 16000 
    showFrq(1) = 15849;
elseif showFrq(2) == 16000
    showFrq(2) = 15849;
end
% ------------------------------------------------------------------------
B2 = round(cF) >= showFrq(1);
cF = cF(B2);
C2 = round(cF) <= showFrq(2);
cF = cF(C2);

for i = 1:length(cF)
octFilters = octaveFilter(cF(i), octaveBand, 'SampleRate', Fs,'FilterOrder',FilterOrder);
OctFilteredSigal(:,i) = octFilters(input);
end

if strcmp('ON', plotOnOff) || strcmp('on', plotOnOff) || strcmp('On', plotOnOff)
    if strcmp('stairs', BarOrStairs)
        plotThis = 10*log10((rms(OctFilteredSigal).^2)/(20e-6)^2);
        plotThis(end + 1) = plotThis(end);
        p = stairs(0:length(centerFrqVec), plotThis);
        xticks(0.5:length(centerFrqVec))
        xticklabels(centerFrqVec)
        xtickangle(45)
        xlabel('Frequency Bands [Hz]')
        ylabel('SPL [dB]')
        grid on
    else
        plotThis = 10*log10((rms(OctFilteredSigal).^2)/(20e-6)^2);
        plotThis(end + 1) = plotThis(end);
        p = bar(0:length(centerFrqVec), plotThis);
        xticks(0.5:length(centerFrqVec))
        xticklabels(centerFrqVec)
        xtickangle(45)
        xlabel('Frequency Bands [Hz]')
        ylabel('SPL [dB]')
        grid on
    end
end

end

