function [smagNote, smagMusic, sphaseMusic] = load_data()
%% Argument Descriptions
% Required Input Arguments:
% None

% Required Output Arguments:
% smagNote: 1025 x 11 matrix containing the mean spectrum magnitudes of the notes. A correct sequence of the notes is REQUIRED. (From left to right: e f g a b c d e2 f2 g2 a2)
% smagMusic: 1025 x K matrix containing the spectrum magnitueds of the music after STFT.
% sphaseMusic: 1025 x K matrix containing the spectrum phases of the music after STFT.

%% Load Spectrum Magnitudes of Notes
% Fill your code here to return 'smagNote'
notesfolder = 'notes15';
listname = dir(fullfile(notesfolder,'*.wav'));
notes=[];
for k = 1:length(listname)
    [s, fs] = audioread([notesfolder filesep listname(k).name]);
    s = s(:, 1);
    s = resample(s, 16000, fs);
    spectrum = stft(s', 2048, 256, 0, hann(2048));
    %Find the central frame 
    middle = ceil(size(spectrum, 2) /2); 
    note = abs(spectrum(:, middle)); 
    %Clean up everything more than 40 db below the peak 
    note(find(note<max(note(:))/100)) = 0 ;
    note = note/norm(note);
    %normalize the note to unit length 
    notes = [notes, note];
end
smagNote=notes;
%% Load Spectrum Magnitues and Phases of The Provided Music
% Fill your code here to return 'smagMusic' and 'sphaseMusic'
[y,Fs] = audioread('polyushka.wav');
spectrum=stft(y', 2048, 256, 0, hann(2048));
smagMusic=abs(spectrum);
sphaseMusic=spectrum./smagMusic;
