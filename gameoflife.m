% Parameter
saveMovie     = 0;
sizeField     = 100;
gameLength    = 100;
gameField     = uint8(zeros(sizeField+2,sizeField+2));
gameFieldTemp = uint8(zeros(sizeField+2,sizeField+2));

% Zeichnen
colormap(gray(2));
image(gameField);
axis equal
axis off

% Interaktion mit dem Plot
% Info: Punkte mit linker Maustaste setzen. Letzen Punkt mit rechter Maustaste setzen
but = 1;
while but == 1
  [x,y,but] = ginput(1);
  x = round(x);
  y = round(y);
  gameField(y+1,x+1) = 1;
  image(gameField(2:end,2:end));
  axis equal
  axis off
  drawnow;
end
  
% Spiel
for idx = 1:gameLength
  for i = 2:sizeField+1
    for k = 2:sizeField+1
      sumCheck = sum([gameField(i+1,k),gameField(i-1,k), ...
                      gameField(i,k+1),gameField(i+1,k+1),gameField(i-1,k+1), ...
                      gameField(i,k-1),gameField(i+1,k-1),gameField(i-1,k-1)]);
      if gameField(i,k) == 0 && sumCheck == 3
        gameFieldTemp(i,k) = 1;
      elseif gameField(i,k) == 1 && (sumCheck == 2 || sumCheck == 3)
        gameFieldTemp(i,k) = 1;
      else
        gameFieldTemp(i,k) = 0;
      end
    end
  end
  gameField = gameFieldTemp;
  if saveMovie ==1
    M(idx) = getframe(gcf);
  end
  image(gameField(2:end,2:end));
  axis equal
  axis off
  drawnow;
  pause(0.02);
end

if saveMovie ==1
  movie(M)
  movie2avi(M, 'gameoflife.avi');
end