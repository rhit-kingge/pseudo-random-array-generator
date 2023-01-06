clc; clear all;

grid_width = 15;
grid_height = 15;
current_best = zeros(grid_height+2,grid_width+2);
plaque_area = (grid_width)*(grid_height);

tile1 = TileByDist(1,1,20,1,1);
tile2 = TileByDist(2,2,40,2,2);
tile3 = TileByDist(3,3,50,20,3);

for generated_plaques = 1:1
    plaque = zeros(grid_height + 2,grid_width + 2);


    [plaque, tile3Count] = tile3.placelens(plaque, 1000);
    [plaque, tile2Count] = tile2.placelens(plaque, 1000);
    [plaque, tile1Count] = tile1.placelens(plaque, 10000);
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


end


%JUST PLOTS
figure(1)
clf(figure(1));
hold on
plot(xInAngles,xoutput3,'Color',[0.9290 0.6940 0.1250]);
plot(xInAngles,xoutput2,'Color',[0.4660 0.6740 0.1880]);
plot(xInAngles,xoutput1,'Color',[0.3010 0.7450 0.9330]);
legend("Tile 3 (largest)", "Tile 2", "Tile 1");
xlabel("Angle from Surface Normal (degrees)");ylabel("Relative Output Intensity of the Present Element Distribution");

figure(2)
plot(xInAngles,totalXOutput,"r");
xlabel("Angle from Surface Normal (degrees)");ylabel("Normalized Intensity");

figure(3)
imagesc(plaque);
xlabel("mm");ylabel("mm");



