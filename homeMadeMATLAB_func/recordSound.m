function recordSound(SoundCard_rec, fileToSave, recordingTime)
% 
% playSound_fromFile(SoundCardplay, fileToPlay)
%
% The function also need the 'record' object from the soundcard. Here
% the function 'soundCardSetup' is used: 
% [record, play, playRecord] = soundCardSetup(usedMic,usedSpeaker, Fs, ...
%                                             driver, soundCard, samplePerFrame)
%
% To make the fileToSave object, following function is use:
% fileToSave = dsp.AudioFileWriter('Name_of_recorded_signal.wav', ...
%                                  'SamplesPerFrame',Fs);


pause(0.2) % bare fordi...
fprintf(['recording ',num2str(recordingTime),' seconds ... \n'])
tic
while toc < recordingTime
    audioFromDevice = SoundCard_rec();
    fileToSave(audioFromDevice);
end
fprintf('done recording \n')
release(fileToSave)
release(SoundCard_rec)

end

