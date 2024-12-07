function [ y ] = acumulativo( theta )
y(1) = 0;
for i = 2:length(theta)
  if(abs(theta(i)-theta(i-1)) <= pi)
    y(i) = y(i-1) + theta(i)-theta(i-1); 
  else
    if(theta(i) > 0)
      y(i) = y(i-1) + (theta(i)-pi);
    else
     y(i) = y(i-1) - (theta(i)+pi);
    end
    
  end
end
end

