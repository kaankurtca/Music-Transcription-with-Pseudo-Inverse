%% Load Notes and Music
clc;
clear all;
close all;
% Use the 'load_data' function here
[smagNote, smagMusic, sphaseMusic] = load_data();
%% Solution for Problem 2_1 here
% Store W in a file called "problem2_1.mat"
% W will be a 15xT matrix, where T is the number of frames in the music.
W=pinv(smagNote)*smagMusic;
W=max(W,0);
save("problem2_1.mat","W");
%% Synthesize Music
% Use the 'synthesize_music' function here.
smagMusicProj=smagNote*W;

synMusic=synthesize_music(smagMusicProj,sphaseMusic);



%soundsc(synMusic);

% Use 'wavwrite' function to write the synthesized music as 'problem2_1_synthesis.wav' to the 'results' folder.
filename='C:\Users\osman\Documents\MATLAB\MLSP_HW!\results\problem2_ 1_synthesis.wav';
fs=44100/2;
audiowrite(filename,synMusic,fs);



%% Solution for Problem 2_2 here

%Find and store the transformation matrix
[p1,Fs1]=audioread('C:\Users\osman\Documents\MATLAB\MLSP_HW!\audio\silentnight_piano.aif');
p1=p1(:,1);
spectrum_p1=stft(p1', 1024, 256, 0, hann(1024));
smagMusic_p1=abs(spectrum_p1);

[g1,Fs2]=audioread('C:\Users\osman\Documents\MATLAB\MLSP_HW!\audio\silentnight_guitar.aif');
g1=g1(:,1);
spectrum_g1=stft(g1', 1024, 256, 0, hann(1024));
smagMusic_g1=abs(spectrum_g1);

W1=pinv(smagMusic_p1)*smagMusic_g1;
W1=max(W1,0);

[p2,Fs3] = audioread('C:\Users\osman\Documents\MATLAB\MLSP_HW!\audio\littlestar_piano.aif');
p2=p2(:,1);
spectrum_p2=stft(p2', 1024, 256, 0, hann(1024));
smagMusic_p2=abs(spectrum_p2);
sphaseMusic_p2=spectrum_p2./smagMusic_p2;
add=zeros(513,2075);
smagMusic_p2= [smagMusic_p2 add];
sphaseMusic_p2=[sphaseMusic_p2 add];

% Apply the transformation matrix to audio C and store the created music using 'synthesize_music' function.
smagMusic_g2=smagMusic_p2*W1;

r=smagMusic_g2.*sphaseMusic_p2;
synMusic_g2=stft(r,1024,256,0,hann(1024));
synMusic_g2=transpose(synMusic_g2);

% Use 'wavwrite' function to write the synthesized music as 'problem2_2_synthesis.wav' to the 'results' folder.
filename='C:\Users\osman\Documents\MATLAB\MLSP_HW!\results\problem2_ 2_synthesis.wav';
fs=44100;
audiowrite(filename,synMusic_g2,fs);