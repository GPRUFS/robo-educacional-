function tecla_pressionada(~, event)
global g

    tecla = event.Key;
    switch tecla
        case 'leftarrow'  % Seta para a esquerda no teclado
            disp('Seta Esquerda pressionada - Executando comando de mover para a esquerda');
            % Adicione aqui o comando para a seta esquerda
            g = 1;
            
        case 'rightarrow'  % Seta para a esquerda no teclado
            disp('Seta Esquerda pressionada - Executando comando de mover para a esquerda');
            % Adicione aqui o comando para a seta esquerda
            g = -1;
            
        case 'uparrow'  % Seta para cima no teclado
            disp('Seta Cima pressionada - Executando comando de mover para cima');
            % Adicione aqui o comando para a seta para cima
            g = 2;
            
        case 'downarrow'  % Seta para cima no teclado
            disp('Seta Cima pressionada - Executando comando de mover para cima');
            % Adicione aqui o comando para a seta para cima
            g = -2;
            
        case 'escape'  % Tecla ESC para fechar a figura
            g = 0;
            disp('Tecla ESC pressionada - Fechando a figura');
            close(gcf);
            
        % Adicione mais comandos personalizados conforme necessário
        otherwise
            disp(['Tente outra...']);
    end
end