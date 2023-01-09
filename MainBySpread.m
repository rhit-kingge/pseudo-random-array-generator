clc; clear all;

grid_width = 10;
grid_height = 10;
current_best = zeros(grid_height+2,grid_width+2);
plaque_area = (grid_width)*(grid_height);
tile1 = TileByDist(1,1,1,"Lens",10,20);
tile2 = TileByDist(2,2,2,"Lens",25,20);
tile3 = TileByDist(3,3,3,"Rough Surface",50);


for generated_plaques = 1:1
    plaque = zeros(grid_height + 2,grid_width + 2);


    [plaque, tile3Count] = tile3.placeElement(plaque, 1000);
    [plaque, tile2Count] = tile2.placeElement(plaque, 1000);
    [plaque, tile1Count] = tile1.placeElement(plaque, 10000);

    xInAngles = -40*pi/180:.005:40*pi/180;
    xoutput3 = tile3Count*tile3.getDistribution(xInAngles)./plaque_area;
    xoutput2 = tile2Count*tile2.getDistribution(xInAngles)./plaque_area;
    xoutput1 = tile1Count*tile1.getDistribution(xInAngles)./plaque_area;
%     xoutput3 = exp(-2*(tan(xInAngles)/(tile3.xSpread*pi/180/2)).^2);
%     xoutput2 = exp(-2*(tan(xInAngles)/(tile2.xSpread*pi/180/2)).^2);
%     xoutput1 = exp(-2*(tan(xInAngles)/(tile1.xSpread*pi/180/2)).^2);
%     wx3 = d*tan(tile3.xSpread*pi/180);
%     wx2 = d*tan(tile2.xSpread*pi/180);
%     wx1 = d*tan(tile1.xSpread*pi/180);
%     xoutput3 = (tile3Count*tile3.area/plaque_area)*exp(-2*(x/wx3).^2);
%     xoutput2 = (tile2Count*tile2.area/plaque_area)*exp(-2*(x/wx2).^2);
%     xoutput1 = (tile1Count*tile1.area/plaque_area)*exp(-2*(x/wx1).^2);

%     xAngOutput3 = zeros(length(x));xAngOutput2 = zeros(length(x));xAngOutput1 = zeros(length(x));
%     xInAngles = atan(x/d)*180/pi;
    totalXOutput = xoutput1 + xoutput2 + xoutput3;


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



