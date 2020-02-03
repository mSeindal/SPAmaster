function [record, play, playRecord] = soundCardSetup(usedMic,usedSpeaker, Fs, samplePerFrame, driver, soundCard)
% [record, play, playRecord] = soundCardSetup(usedMic,usedSpeaker, Fs, samplePerFrame, driver, soundCard)
%
% Setup sound card returns:
%       record: only recording
%       play: playback only
%       playRecord: playback and recording simultaneously 
%
% usedMic and usedSpeaker can be a single number (mic/spk input) or a
% vector of number if the sound card have more than one input/output
%
% Fs = sampling frequency
%
% samplePerFrame = how many samples per frame
%
% driver is the used driver, fx:
%       'DirectSound'
%       'ASIO'
%
% soundCard is the used sound card, fx:
%       'Default'
%       'ASIO Fireface USB'
%       'ASIO MADIface USB'
%



samplerate = Fs;
inputChannelMap = usedMic; % hvor mange mic, skal der bruges
outputChannelMap = usedSpeaker; % speaker output outside the car


record = audioDeviceReader('Driver',driver,...
    'SampleRate',samplerate,...
    'SamplesPerFrame', samplePerFrame,...
    'Device',soundCard,...
    'ChannelMappingSource','Property',...
    'ChannelMapping',inputChannelMap,...
    'BitDepth', '24-bit integer');

play = audioDeviceWriter('Driver',driver,...
    'SampleRate',samplerate,...
    'Device',soundCard,...
    'ChannelMappingSource','Property',...
    'ChannelMapping',outputChannelMap,...
    'BitDepth', '24-bit integer');

playRecord = audioPlayerRecorder('SampleRate',samplerate,...
                          'PlayerChannelMapping',outputChannelMap,...
                          'RecorderChannelMapping',inputChannelMap,...
                          'BitDepth', '24-bit integer');
end

