% Parameter
saveMovie     = 1;
sizeField     = 100;
gameLength    = 50;
gameField     = zeros(sizeField+1,sizeField+1);
gameFieldTemp = zeros(sizeField+1,sizeField+1);
hr            = zeros(sizeField+1,sizeField+1);

% Spielfeld zufällig füllen
for x = 2:sizeField-1
  for y = 2:sizeField-1
    randomNr = randi([0 10],1);
    if randomNr == 10
      gameField(x,y) = 1;
    else
      gameField(x,y) = 0;
    end
  end
end

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

  for i = 2:sizeField
    for k = 2:sizeField
      if gameField(i,k) == 1
        hr(i-1,k-1)=fill([i-2 i-2 i-1],[k-2 k-1 k-2],'k','EdgeColor','none');
        hr2(i-1,k-1)=fill([i-1 i-1 i-2],[k-1 k-2 k-1],'k','EdgeColor','none');
      else
        hr(i-1,k-1)=fill([i-2 i-2 i-1],[k-2 k-1 k-2],'w','EdgeColor','none');
        hr2(i-1,k-1)=fill([i-1 i-1 i-2],[k-1 k-2 k-1],'w','EdgeColor','none');
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
        set(hr(i,k),'FaceColor','k')
        set(hr2(i,k),'FaceColor','k')
      elseif gameField(i,k) == 1 && sumCheck == 1 || sumCheck == 2
        gameFieldTemp(i,k) = 1;
        set(hr(i,k),'FaceColor','k')
        set(hr2(i,k),'FaceColor','k')
      else
        gameFieldTemp(i,k) = 0;
        set(hr(i,k),'FaceColor','w')
        set(hr2(i,k),'FaceColor','w')
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