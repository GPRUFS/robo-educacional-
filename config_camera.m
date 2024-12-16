clear cam
List = webcamlist;
cam = webcam(1);


 cam.Resolution = '1280x720';
 cam.BacklightCompensation = 2;
 cam.Brightness = 38; 
 cam.Contrast = 10;
 cam.ExposureMode = 'manual';
 cam.Exposure = -8;
 cam.FocusMode = 'manual';
 cam.Focus = 0;
 cam.Pan = 0;
 cam.Saturation = 146;
 cam.Sharpness = 50;
 cam.Tilt = 0;
 cam.WhiteBalanceMode = 'auto';
%   cam.Zoom = 6;

% cam.Resolution = '640x480';
% cam.BacklightCompensation = 0;
% cam.Brightness = 120; 
% cam.Contrast = 10;
% cam.ExposureMode = 'auto';
% % cam.FocusMode = 'auto';
% cam.Pan = 0;
% cam.Saturation = 200;
% % cam.Sharpness = 50;
% cam.Tilt = 0;
% cam.WhiteBalanceMode = 'auto';
% % cam.Zoom = 7;