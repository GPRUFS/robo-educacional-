delete(instrfindall); % Fecha e apaga todos os objetos de comunicação

% Define a porta COM
comPort = 'COM3'; % Substitua por sua porta COM

% Cria o objeto serial
s = serial(comPort);

% Configura propriedades
s.BaudRate = 115200;            % Taxa de transmissão (ajuste conforme necessário)
s.InputBufferSize = 10;       % Tamanho do buffer de entrada em bytes
s.Terminator = 'LF';            % Define o terminador como Line Feed (\n)

% Abre a conexão
fopen(s);

% % Fecha a conexão
% fclose(s);
% 
% % Remove o objeto serial
% delete(s);
% clear s;
