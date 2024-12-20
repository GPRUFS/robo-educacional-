clc
clear
close all

config_camera
config_usb

% Criar uma figura
figure;
escala = 2.15*2; %O DOBRO PR O CAMPO

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
%   drawnow
  img = snapshot(cam);
  [Ir, Ib, Io, Ig, Iy] = Cores(img);
  
  se = strel('disk', 3);
  Ig = imopen(Ig, se);
  Ib = imopen(Ib, se);
  Io = imopen(Io, se);  
  im_aberto = imopen(img, se);
% [Ir, Ib, Io, Ig] = HSV_im(img);
  
  %% Pose do rob� e posi��o da bola (escala depois pra melhor medida)
  [yr , xr] = find(Ig==1);
  [yb , xb] = find(Ib==1);
  [yl , xl] = find(Io==1);
  % medias das cordenadas y
  myr = mean(yr)/escala; %red
  myb = mean(yb)/escala; %blue
  myl = mean(yl)/escala; %orange
  % medias das cordenadas x
  mxr = mean(xr)/escala; %red
  mxb = mean(xb)/escala; %blue
  mxl = mean(xl)/escala; %orange
  % posição e angulação do robô
  xrb = mean([mxr , mxb]);
  yrb = mean([myr , myb]);
  thrb = 180*atan2((myb-myr),(mxb-mxr))/pi; %graus
  
  xb = mxl;
  yb = myl;
  Pdes = [xb,yb];
  time = time+1; %quantas vezes passou no loop, ou seja, amostrou
  Pos = [xrb  yrb  thrb*pi/180]; %[cm ; cm ; rad]
  
  
  d = sqrt((Pos(1)-Pdes(1))^2 + (Pos(2)-Pdes(2))^2);
  theta_d = atan2((Pdes(2)-Pos(2)),(Pdes(1)-Pos(1)));
  
  % converte theta_e para -pi a pi
  if theta_d > pi, theta_d = theta_d - 2*pi; end
  if theta_d < -pi, theta_d = theta_d + 2*pi; end
  
  theta_e = theta_d - Pos(3);
  
  % converte theta_e para -pi a pi
  if theta_e > pi, theta_e = theta_e - 2*pi; end
  if theta_e < -pi, theta_e = theta_e + 2*pi; end
  
  % Calculo para cinematica direta
  L = 5;
  r = 1.5; %raio do robô para verificar colisão e plotar o robô [cm]
  Modcin = [r/2 , r/2 ; -r/(2*L) r/(2*L)];
  fi_max = 8*pi; %velocidade máxima de rotação da roda em radianos por segundo
  %8 voltas por segundo
  
  Fi = [fi_max ; fi_max];
  aux = Modcin*Fi;
  Vmax = aux(1); %cálculo da vellcidade linear máxima a partir do modelo identificado [cm/s]
  Fi = [-fi_max ; fi_max];
  aux = Modcin*Fi;
  Wmax = aux(2); %cálculo da vellcidade angular máxima a partir do modelo identificado [rad/s]

   kv = 0.01;
   kw = 0.5;
   sig = theta_e/abs(theta_e);
   V = Vmax*tanh(kv*d)*cos(theta_e/2);
   W = Wmax*tanh(theta_e*kw);
   (180/pi)*theta_e
   d
%    W = 0;
%    V = Vmax*0.4;
  
  aux = inv(Modcin)*[V; W];
  fi1 = aux(1);
  fi2 = aux(2);
  
  per1 = fi2/fi_max;
  per2 = fi1/fi_max;
  
  v1 = per1*250;
  v2 = per2*250;
  v2 = toNonLinearControl(v1)
  v1 = toNonLinearControl(v2)
  
  
  
  %%  Escala linear
%   esc = 0:50:250;
%   for i = 2:1:length(esc)
%      if(v1 > esc(i-1) && v1 <= esc(i))
%          v1 = esc(i-1);
%      end
%      if(v2 > esc(i-1) && v2 <= esc(i))
%          v2 = esc(i-1);
%      end
%   end  
  %%
   
%       comunica(v1, v2,s);  
  comunica(0, 0,s); 
  
  T(time) = toc;
  
    % Espera por uma tecla ser pressionada
    key = get(gcf, 'CurrentKey');
%     pause(0.1)
    
    % Parar o loop quando a tecla 'space' for pressionada
    if strcmp(key, 'space')
        break;
    end

  % salvando comandos enviados
  v_ang(time) = W;
  v_lin(time) = V;

  img2 = imresize(im_aberto,1/escala);
  image(img2)
  axis equal
  hold on
  plot(mxr,myr, 'r*')
  hold on
  plot(mxb,myb, 'm*')
  hold on
  plot(mxl,myl, 'k*')
  hold on
  quiver(xrb,yrb,2*(mxb-mxr),2*(myb-myr),0,'c','MaxHeadSize',1,'linewidth',2)
  hold off
  drawnow

end
% Fechar a figura ao final
close(gcf);
% Parar robô
comunica(0, 0,s);


%% controlador
figure(1)
subplot(1,2,1)
plot(T, v_ang)
hold on
w = angular(Pos, T);
plot(T, w)
subplot(1,2,2)
plot(T, v_lin)
hold on
v = linear(Pos, T);
plot(T, v)


function y = toNonLinearControl(x)

if(x) < 100 y =0;
else y = 170;
end
end