camList = webcamlist;
cam = webcam(2);

cam.resolution = '1280x720';
cam.FocusMode = 'manual';
cam.Focus = 0;
cam.ExposureMode = 'manual';
cam.Exposure = -8;
cam.Contrast = 0; %entre 0 e 10
cam.Saturation = 200; %entre 0 e 200
cam.Brightness = 30; %entre 30 e 255