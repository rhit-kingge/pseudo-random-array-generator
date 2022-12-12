clc; clear all;

grid_width = 20;
grid_height = 20;
current_best = zeros(grid_height,grid_width);
rays = Ray.empty;
empty_tiles = grid_width*grid_height;

tile1 = Tile(1,1,10,1,1);
tile2 = Tile(2,2,40,2,2);
tile3 = Tile(3,3,55,20,3);
target1 = round(empty_tiles/3);
target2 = round(empty_tiles/3);
target3 = round(empty_tiles/3);
prev_merit = 10000;

for generated_plaques = 1:1
    plaque = zeros(grid_height,grid_width);

    %plaque = tile3.placelens(plaque, target3, 1000);
    [plaque, rays] = tile3.placelens(plaque, target3, 1000, rays);
    [plaque, rays] = tile2.placelens(plaque, target2, 1000, rays);
    [plaque, rays] = tile1.placelens(plaque, 1000, 10000, rays);



    %Merit function
%     merit = sqrt((target3-n3)^2+(target2-n2)^2);
%     if merit < prev_merit
%         current_best = plaque;
%         prev_merit = merit;
%     end

end
figure(1);
clf(figure(1));
hold on;
imagesc(plaque);
for n = 1:length(rays)
    plot(rays(n).xOrigin,rays(n).yOrigin,'r*')
end

figure(2);
clf(figure(2));
xAngles = zeros(size(rays));
yAngles = zeros(size(rays));
for n = 1:length(rays)
    xAngles(n) = rays(n).xAngle*180/pi;
    yAngles(n) = rays(n).yAngle*180/pi;
end

histogram(xAngles, 181, 'BinLimits', [-90, 90]);


%Currently looking into fitdist, trying to fit to cos^3(theta) where theta
%will have to be scaled to our desired spread, where the intensity equals
%zero when theta is 90degrees.
%Because the equation is Im*cos^3(theta*scaler)
%modelFun = @(Im,s) 
