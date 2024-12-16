camList = webcamlist;
cam = webcam(2);
cam.resolution = '1280x720';
cam.FocusMode = 'manual';
cam.Focus = 0;
cam.ExposureMode = 'manual';
cam.Exposure = -8;
cam.Contrast = 10; %entre 0 e 10
cam.Saturation = 200; %entre 0 e 200
cam.Brightness = 30; %entre 30 e 255
pause(0.1)

cam.Brightness = 100; %entre 30 e 255
pause(0.1)
cam.Brightness = 30; %entre 30 e 255
% see = strel('disk',5);


escala = 2.15;
 img = snapshot(cam);
 img = imresize(img,1/escala);
 img = flipud(img);
[Ir,Ib] = vermelhoazul(img);
%  Ir = imopen(Ir);
% Ib = imopen(Ib,see);
% Ig = imopen(Ig,see);


%% Pose do robô (escala depois pra melhor medida)
[yr , xr] = find(Ir==1);
[yb , xb] = find(Ib==1);
myr = mean(yr)/escala;
myb = mean(yb)/escala;
mxr = mean(xr)/escala;
mxb = mean(xb)/escala;    
xrb = mean([mxr , mxb]);
yrb = mean([myr , myb]);
thrb = 180*atan2((myr-myb),(mxr-mxb))/pi; %graus

Pos = [xrb ; yrb ; thrb*pi/180]; %[cm ; cm ; rad]

img2 = imresize(img,1/2.15);
image(img2)
axis equal
hold on
quiver(xrb,yrb,2*(mxr-mxb),2*(myr-myb),0,'c','MaxHeadSize',1,'linewidth',2)
hold off
drawnow

% r = 5;
% d = 10;
% [v; w] = 1/2*[r r; r/d -r/d]*[fir; fil];