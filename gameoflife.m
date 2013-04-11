% Parameter
saveMovie     = 0;
sizeField     = 20;
gameLength    = 100;
gameField     = zeros(sizeField+2,sizeField+2);
gameFieldTemp = zeros(sizeField+2,sizeField+2);
hr            = zeros(sizeField,sizeField);
hr2           = zeros(sizeField,sizeField);

% Zeichnen
hf = figure('color','black');
axis off
axis equal
hold on

% Speedup
setappdata(gca,'LegendColorbarManualSpace',1);
setappdata(gca,'LegendColorbarReclaimSpace',1);
xlim([0,sizeField]);
ylim([0,sizeField]);

  for i = 2:sizeField+1
    for k = 2:sizeField+1
      if gameField(i,k) == 1
        hr(i-1,k-1)=fill([i-2 i-2 i-1],[k-2 k-1 k-2],'k','EdgeColor','none');
        hr2(i-1,k-1)=fill([i-1 i-1 i-2],[k-1 k-2 k-1],'k','EdgeColor','none');
      else
        hr(i-1,k-1)=fill([i-2 i-2 i-1],[k-2 k-1 k-2],'w','EdgeColor','none');
        hr2(i-1,k-1)=fill([i-1 i-1 i-2],[k-1 k-2 k-1],'w','EdgeColor','none');
      end
    end
  end
  
  % Interaktion mit dem Plot
  % Info: Punkte mit linker Maustaste setzen. Letzen Punkt mit rechter Maustaste setzen
  but = 1;
  while but == 1
    [x,y,but] = ginput(1);
    x = ceil(x);
    y = ceil(y);
    gameField(x+1,y+1) = 1;
    set(hr(x,y),'FaceColor','k')
    set(hr2(x,y),'FaceColor','k')
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
        set(hr(i-1,k-1),'FaceColor','k')
        set(hr2(i-1,k-1),'FaceColor','k')
      elseif gameField(i,k) == 1 && (sumCheck == 2 || sumCheck == 3)
        gameFieldTemp(i,k) = 1;
        set(hr(i-1,k-1),'FaceColor','k')
        set(hr2(i-1,k-1),'FaceColor','k')
      else
        gameFieldTemp(i,k) = 0;
        set(hr(i-1,k-1),'FaceColor','w')
        set(hr2(i-1,k-1),'FaceColor','w')
      end
    end
  end
  gameField = gameFieldTemp;
  if saveMovie ==1
    M(idx) = getframe(gcf);
  end
  drawnow
end

if saveMovie ==1
  movie(M)
  movie2avi(M, 'gameoflife.avi');
end