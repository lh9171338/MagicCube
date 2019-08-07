%% MagicCube_demo
clear,clc;
close all;

%% Initial Magic Cube
option = struct('Order', 3, 'Size', 20, 'Draw3d', false, 'Iter', 20);
MagicCube = InitMagicCube(option);

%% Draw
figure;
DrawMagicCube(MagicCube);

       

