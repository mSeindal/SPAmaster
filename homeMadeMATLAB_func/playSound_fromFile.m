function playSound_fromFile(SoundCardplay, fileToPlay)
% 
% playSound_fromFile(SoundCardplay, fileToPlay)
%
% The function also need the 'play' object from the soundcard. Here
% the function 'soundCardSetup' is used: 
% [record, play, playRecord] = soundCardSetup(usedMic,usedSpeaker, Fs, ...
%                                             driver, soundCard, samplePerFrame)
%
% To make the fileToPlay object, following function is use:
% fileToPlay = dsp.AudioFileReader('Name_of_signal_to_play.wav', ...
%                                  'SamplesPerFrame',samplePerFrame);
%
%


pause(0.2) % bare fordi...
fprintf('Playing... \n')
while ~isDone(fileToPlay)
    SoundCardplay(fileToPlay());
end
fprintf('done playing \n')
release(fileToPlay)
release(SoundCardplay)


end

