% Parameter
sizeField     = 40;
gameLength    = 50;
gameField     = zeros(sizeField+1,sizeField+1);
gameFieldTemp = zeros(sizeField+1,sizeField+1);

% Spielfeld zuf�llig f�llen
for x = 2:sizeField-1
  for y = 2:sizeField-1
    randomNr = randi([0 2],1);
    if randomNr == 2
      gameField(x,y) = 1;
    else
      gameField(x,y) = 0;
    end
  end
end

% Spiel
for idx = 1:gameLength
  for i = 2:sizeField-1
    for k = 2:sizeField-1
      sumCheck = sum([gameField(i+1,k),gameField(i-1,k), ...
                      gameField(i,k+1),gameField(i+1,k+1),gameField(i-1,k+1), ...
                      gameField(i,k-1),gameField(i+1,k-1),gameField(i-1,k-1)]);
      if gameField(i,k) == 0 && sumCheck == 3
        gameFieldTemp(i,k) = 1;
      elseif gameField(i,k) == 1 && sumCheck == 1 || sumCheck == 2
        gameFieldTemp(i,k) = 1;
      else
        gameFieldTemp(i,k) = 0;
      end
    end
  end
  gameField = gameFieldTemp;
  
% Zeichnen  
  axis off
  axis equal
  hold on
  title(num2str(idx));
  for i = 2:sizeField
    for k = 2:sizeField
      if gameField(i,k) == 1
        fill([i-2 i-2 i-1],[k-2 k-1 k-2], 'k')
        fill([i-1 i-1 i-2],[k-1 k-2 k-1], 'k')
      else
        fill([i-2 i-2 i-1],[k-2 k-1 k-2], 'w')
        fill([i-1 i-1 i-2],[k-1 k-2 k-1], 'w')
      end
    end
  end
  M(idx) = getframe(gcf);
  drawnow
end
movie(M)
movie2avi(M, 'gameoflife.avi');