function w = linear(Pos, T)

  y = Pos(2,:);
  x = Pos(1,:);
  n = length(y)-1;

  y = acumulativo(y);
  T(1) = 0;
  x = acumulativo(x);
  vec = sqrt(x.^2 + y.^2);

  v = (vec(2:end) - vec(1:end-1))/tamos;
  v = [v v(end)];
  v = [v(8:end) zeros(1,7)];
  %% Filtragem da derivada, filtro passa baixa de primeira ordem
  ordem = 10;
  a = 0.2;
  for k = 1:ordem
    v(2:end) = a*v(1:end-1) + (1-a)*v(2:end); 
  end

end