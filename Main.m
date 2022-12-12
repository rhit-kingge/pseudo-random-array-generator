clc; clear all;

%Tile 3
% n = 1.4926;     %Refractive index of PMMA according to refractiveindex.info
% spread3 = 45*pi/180;  %Output angle, technically working in reverse
% NA3 = n*sin(-spread3);      %The numerical aperture of a PMMA lens with a 45 degree output
% D = 3;
% R3 = -NA3*D/(n-1);

%Tile 2


%Tile 1

grid_width = 10;
grid_height = 10;
current_best = zeros(grid_height,grid_width);
rays = Ray.empty;
empty_tiles = grid_width*grid_height;

tile1 = Tile(1,1,1,1,1);
tile2 = Tile(2,2,2,2,2);
tile3 = Tile(3,3,45,20,3);
target1 = round(empty_tiles/3);
target2 = round(empty_tiles/3);
target3 = round(empty_tiles/3);
prev_merit = 10000;

for generated_plaques = 1:1
    plaque = zeros(grid_height,grid_width);

    %plaque = tile3.placelens(plaque, target3, 1000);
    [plaque, rays] = tile3.placelens(plaque, target3, 1000, rays);
%     [plaque, rays] = tile2.placelens(plaque, target2, 1000, rays);
%     [plaque, rays] = tile1.placelens(plaque, 1000, 1000, rays);
    %plaque = tile2.placelens(plaque, target2, 1000);
    %plaque = tile1.placelens(plaque, 175, 100000);


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
