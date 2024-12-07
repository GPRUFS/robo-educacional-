%% Nome da porta Serial a ser Conectada
% dispositivo = serialport('COM3',9600);

%Configuracao da portal serial
delete(instrfindall); %limpa todos os instrumentos anteriormente abertos no serial
dispositivo = serial('COM4'); %variavel s da porta serial

set(dispositivo,'InputBufferSize', 10); %numero de bytes que o buffer armazena
set(dispositivo,'BaudRate', 9600);
set(dispositivo,'Parity','none');
set(dispositivo, 'DataBits', 8);

fopen(dispositivo);
flushinput(dispositivo);