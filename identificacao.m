clc
clear
close all

config_camera
config_usb

escala = 2.15*2;

 vel = 0;
 Comando = [];
 Comando = [Comando vel];

time = 1;
T = [];
Tstart = tic;
tic
flag = 0;
T(1) = Tstart;
while(1)
  
  img = snapshot(cam);
  [Ir,Ib, Il] = Cores(img);
  
  %% Pose do robÙ e posiÁ„o da bola (escala depois pra melhor medida)
  [yr , xr] = find(Ir==1);
  [yb , xb] = find(Ib==1);
  [yl , xl] = find(Il==1);
  myr = mean(yr)/escala; %red
  myb = mean(yb)/escala; %blue
  myl = mean(yl)/escala; %orange
  mxr = mean(xr)/escala; %red
  mxb = mean(xb)/escala; %blue
  mxl = mean(xl)/escala; %orange
  xrb = mean([mxr , mxb]);
  yrb = mean([myr , myb]);
  thrb = 180*atan2((myb-myr),(mxb-mxr))/pi; %graus
  xb = mxl;
  yb = myl;
  Pdes = [xb,yb];
  time = time+1; %quantas vezes passou no loop, ou seja, amostrou
  Pos = [xrb  yrb  thrb*pi/180]; %[cm ; cm ; rad]
  
  
  d = sqrt((Pos(1)-Pdes(1))^2 + (Pos(2)-Pdes(2))^2)
  theta_d = atan2((Pdes(2)-Pos(2)),(Pdes(1)-Pos(1)));
  
  % converte theta_e para -pi a pi
  if theta_d > pi, theta_d = theta_d - 2*pi; end
  if theta_d < -pi, theta_d = theta_d + 2*pi; end
  
  theta_e = theta_d - Pos(3);
  
  % converte theta_e para -pi a pi
  if theta_e > pi, theta_e = theta_e - 2*pi; end
  if theta_e < -pi, theta_e = theta_e + 2*pi; end
  
  L = 5;
  r = 1.5; %raio do rob√¥ para verificar colis√£o e plotar o rob√¥ [cm]
  Modcin = [r/2 , r/2 ; -r/(2*L) r/(2*L)];
  fi_max = 8*2*pi; %velocidade m√°xima de rota√ß√£o da roda em radianos por segundo
  %8 voltas por segundo
  
  Fi = [fi_max ; fi_max];
  aux = Modcin*Fi;
  Vmax = aux(1); %c√°lculo da vellcidade linear m√°xima a partir do modelo identificado [cm/s]
  Fi = [-fi_max ; fi_max];
  aux = Modcin*Fi;
  Wmax = aux(2); %c√°lculo da vellcidade angular m√°xima a partir do modelo identificado [rad/s]
 
  
   kv = 0.01;
   kw = 0.15;
   V = Vmax*tanh(kv*d);
   W = Wmax*tanh(kw*theta_e)
   V = Vmax*0.4;
% W = 0
  
  aux = inv(Modcin)*[V; W];
  fi1 = aux(1);
  fi2 = aux(2);
  
  per1 = fi1/fi_max;
  per2 = fi2/fi_max;
  
  v1 = per1*250;
  v2 = per2*250;
%   
%   x_min = 100; %acima da zona morta
%   x_max = 250;
%   
%   % N˙mero de divisıes
%   n = 3;
%   % Gerar pontos no espaÁo logarÌtmico
%   log_min = log10(log10(x_min));
%   log_max = log10(log10(x_max));
%   log_log_points = linspace(log_min, log_max, n+1);
%   % Converter de volta para o espaÁo linear
%   scale = 10.^(10.^log_log_points);
%   scale = [0 round(scale)];
%   aux = [v1;v2];
%   for i = 1:2
%     v = aux(i);
%     if(v < scale(2)) v = scale(1); end
%     if(v >= scale(2) && v < scale(3)) v = scale(2); end
%     if(v >= scale(3) && v < scale(4)) v = scale(4); end
%     if(v >= scale(4)) v = scale(4); end
%     V(i) = v;
%   end
%   
%   v1 = V(1);
%   v2 = V(2);
%   V
%   
  comunica(v1, v2,dispositivo);
  
  
  T(time) = toc;
  
  if time > 100000   %length(vel) para est√°tico
    break;
  end
  
  img2 = imresize(img,1/escala);
  image(img2)
  axis equal
  hold on
  plot(mxr,myr, 'k*')
  hold on
  plot(mxb,myb, 'k*')
  hold on
  plot(mxl,myl, 'k*')
  hold on
  quiver(xrb,yrb,2*(mxb-mxr),2*(myb-myr),0,'c','MaxHeadSize',1,'linewidth',2)
  hold off
  drawnow

end
