function playRecSound_fromFile(SoundCard_playRec, fileToPlay, fileToSave)
% 
% playRecSound_fromFile(SoundCard_playRec, fileToPlay, fileToSave)
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
% ALSO!! ->
% To make the fileToSave object, following function is use:
% fileToSave = dsp.AudioFileWriter('Name_of_recorded_signal.wav', ...
%                                  'SamplesPerFrame',Fs);


pause(0.2) % bare fordi...
fprintf('playing and recording... \n')
while ~isDone(fileToPlay)
    [audioRecorded,nUnderruns,nOverruns] = SoundCard_playRec(fileToPlay());
    
    fileToSave(audioRecorded)
    if nUnderruns > 0
        fprintf('Audio player queue was underrun by %d samples.\n',nUnderruns)
    end
    if nOverruns > 0
        fprintf('Audio recorder queue was overrun by %d samples.\n',nOverruns)
    end
end
fprintf('done playing and recording \n')
release(fileToSave)
release(fileToPlay)
release(SoundCard_playRec)

end

