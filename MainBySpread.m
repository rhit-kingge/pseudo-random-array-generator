clc; clear all;

grid_width = 20;
grid_height = 25;
current_best = zeros(grid_height+2,grid_width+2);
plaque_area = (grid_width)*(grid_height);
tile1 = TileByDist(1,1,1,"Rough Surface",1500);
tile2 = TileByDist(2,2,2,"Rough Surface",1000);
tile3 = TileByDist(3,2,3,"Rough Surface",1000);
tile4 = TileByDist(4,1,2,"Rough Surface",1000);


for generated_plaques = 1:1
    plaque = zeros(grid_height + 2,grid_width + 2);

    [plaque, tile4Count] = tile4.placeElement(plaque, 1000);
    [plaque, tile3Count] = tile3.placeElement(plaque, 1000);
    [plaque, tile2Count] = tile2.placeElement(plaque, 1000);
    [plaque, tile1Count] = tile1.placeElement(plaque, 10000);

    xInAngles = -70*pi/180:.005:70*pi/180;
    xoutput4 = tile3Count*tile4.getDistribution(xInAngles)./plaque_area;
    xoutput3 = tile3Count*tile3.getDistribution(xInAngles)./plaque_area;
    xoutput2 = tile2Count*tile2.getDistribution(xInAngles)./plaque_area;
    xoutput1 = tile1Count*tile1.getDistribution(xInAngles)./plaque_area;
    totalXOutput = xoutput1 + xoutput2 + xoutput3 + xoutput4;


    idealXOutput = zeros(length(xInAngles));


end


%JUST PLOTS
figure(1)
clf(figure(1));
hold on
plot(xInAngles*180/pi,xoutput3,'Color',[0.9290 0.6940 0.1250]);
plot(xInAngles*180/pi,xoutput2,'Color',[0.4660 0.6740 0.1880]);
plot(xInAngles*180/pi,xoutput1,'Color',[0.3010 0.7450 0.9330]);
legend("Tile 3 (largest)", "Tile 2", "Tile 1");
xlabel("Angle from Surface Normal (degrees)");ylabel("Relative Output Intensity of Each Element Type (summed)");

figure(2)
plot(xInAngles*180/pi,totalXOutput,"r");
xlabel("Angle from Surface Normal (degrees)");ylabel("Normalized Intensity");

figure(3)
imagesc(plaque);
xlabel("mm");ylabel("mm");



