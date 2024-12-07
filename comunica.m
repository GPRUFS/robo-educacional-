function comunica(v1,v2,dispositivo)
%% cria a palavra a ser transmitida (10 bytes)

valor = zeros(1,10);
valor(1) = 254; % byte de sincronia (configurado como 254 no STM)
logica = uint8(0);


 if v1 >= 0, logica = bitset(logica,2); end
 if v1 < 0, logica = bitset(logica,3); end
 if v2 >= 0, logica = bitset(logica,4); end
 if v2 < 0, logica = bitset(logica,5); end
 valor(8) = logica;
 valor(9) = abs(v1);  %MOTOR 1 (ESQUERDA)
 valor(10) = abs(v2); %MOTOR 2 (DIREITA)

 msg = valor;
 fwrite(dispositivo,msg,'uint8')

end
