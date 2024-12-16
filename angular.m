function w = angular(Pos, T)

  y = Pos(3,:);
  n = length(y)-1;

  for i = 1:length(y) % coloca os angulos de -pi a pi
      if y(i) > pi, y(i) = y(i) - 2*pi; end
      if y(i) < -pi, y(i) = y(i) + 2*pi; end
  end

  y = acumulativo(y);
  T(1) = 0;

  w = (y(2:end) - y(1:end-1))/tamos;
  w = [w w(end)];
  w = [w(8:end) zeros(1,7)];
  %% Filtragem da derivada, filtro passa baixa de primeira ordem
  ordem = 10;
  a = 0.2;
  for k = 1:ordem
    w(2:end) = a*w(1:end-1) + (1-a)*w(2:end); 
  end

end
