function [synMusic] = synthesize_music(smagMusicProj,sphaseMusic)
%% Argument Descriptions
% Required Input Arguments:
% sphaseMusic: 1025 x K matrix containing the spectrum phases of the music after STFT.
% smagMusicProj: 1025 x K matrix, reconstructed version of smagMusic using transMatT

% Required Output Arguments:
% synMusic: N x 1 music signal reconstructed using STFT.

%% Music synthesis
% Fill your code here to return 'synMusic'
r=smagMusicProj.*sphaseMusic;
synMusic=stft(r,2048,256,0,hann(2048));
synMusic=transpose(synMusic);
