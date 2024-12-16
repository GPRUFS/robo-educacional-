%delete(instrfindall); % Limpa todos os objetos serial antigos
clear
clc
close

global g

fig = figure;
drawnow
set(gcf, 'KeyPressFcn', @tecla_pressionada);

config_usb
%% cria a palavra a ser transmitida (10 bytes)

valor = zeros(1,10);
valor(1) = 254; % byte de sincronia (configurado como 254 no STM)

vv = 150;

v1 = 0;
v2 = 0;

while(1)
    
    drawnow
  
    
if g == -1
    v1 = -vv;
    v2 = vv;
end
if g == 1
    v1 = vv;
    v2 = -vv;
end
if g == 2
    v1 = vv;
    v2 = vv;
end
if g == -2
    v1 = -vv;
    v2 = -vv;
end
if g == 0
    v1 = 0;
    v2 = 0;
end


% v1 = vv;
% v2 = vv;
logica = uint8(0);
if v1 >= 0, logica = bitset(logica,2); end
if v1 < 0, logica = bitset(logica,3); end
if v2 >= 0, logica = bitset(logica,4); end
if v2 < 0, logica = bitset(logica,5); end
valor(8) = logica;
valor(9) = abs(v1);  %MOTOR 1 (ESQUERDA)
valor(10) = abs(v2); %MOTOR 2 (DIREITA)

msg = valor;
fwrite(s,msg,'uint8');
% pause(1)

end

% Fecha a conexão
fclose(s);

% Remove o objeto serial
delete(s);
clear s;

