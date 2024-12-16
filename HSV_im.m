function [Ir, Ib, Io, Ig] = HSV_im(RGB)

% Convert RGB image to chosen color space
I = rgb2hsv(RGB);
%% VERMELHO
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.917;
channel1Max = 0.038;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.582;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.412;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
Ir = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

%% AZUL
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.589;
channel1Max = 0.645;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.498;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.867;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
Ib = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

%% LARANJA
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.023;
channel1Max = 0.079;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.708;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.867;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
Io = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

%% VERDE
% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.226;
channel1Max = 0.414;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.318;
channel2Max = 0.888;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.773;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
Ig = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);

end
