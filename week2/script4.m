% Script 3
% Zero-pressure-gradient turbulent boundary layer

clear;
close all;

global Re_L ue0 duedx

% Set the Reynolds number
Re = 0.9e6;

% Velocity gradient
duedx = -0.25;

% Starting velocity
ue0 = 1;