clc; clear all;

grid_width = 16;
grid_height = 16;
current_best = zeros(grid_height,grid_width);
plaque_area = (grid_width-2)*(grid_height-2);

tile1 = TileByDist(1,1,20,1,1);
tile2 = TileByDist(2,2,40,2,2);
tile3 = TileByDist(3,3,50,20,3);
target1 = round(plaque_area/3);
target2 = round(plaque_area/3);
target3 = round(plaque_area/3);

for generated_plaques = 1:1
    plaque = zeros(grid_height,grid_width);


    [plaque, tile3Count] = tile3.placelens(plaque, target3, 1000);
    [plaque, tile2Count] = tile2.placelens(plaque, target2, 1000);
    [plaque, tile1Count] = tile1.placelens(plaque, 1000, 10000);
    d = 20;
    x0 = d*tan(85*pi/180);
    x = -x0:.2:x0;
    %Correction/area factor should be area the type of lens takes up over
    %total area, so # of that tile times that tile's area over plaque area
    wx3 = d*tan(tile3.xSpread*pi/180);
    wx2 = d*tan(tile2.xSpread*pi/180);
    wx1 = d*tan(tile1.xSpread*pi/180);
    xoutput3 = (tile3Count*tile3.area/plaque_area)*exp(-2*(x/wx3).^2);
    xoutput2 = (tile2Count*tile2.area/plaque_area)*exp(-2*(x/wx2).^2);
    xoutput1 = (tile1Count*tile1.area/plaque_area)*exp(-2*(x/wx1).^2);
    xAngOutput3 = zeros(length(x));xAngOutput2 = zeros(length(x));xAngOutput1 = zeros(length(x));
    xInAngles = atan(x/d)*180/pi;
    totalXOutput = xoutput1 + xoutput2 + xoutput3;
    idealXOutput = zeros(length(xInAngles));
%     idealXOutput();


end

figure(1)
plot(xInAngles,xoutput3,xInAngles,xoutput2,xInAngles,xoutput1)
legend("Tile 3 (largest)", "Tile 2", "Tile 1")

figure(2)
plot(xInAngles,totalXOutput);

figure(3)
imagesc(plaque);
% h = histogram(xAngles, 361, 'BinLimits', [-90, 90]);
% x = h.BinEdges;
% x(end)=[];
% x = x(h.BinCounts > 0);
% y = h.BinCounts(h.BinCounts > 0);
% plot(x,y)


