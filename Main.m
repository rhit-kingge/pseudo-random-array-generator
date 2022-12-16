clc; clear all;

grid_width = 10;
grid_height = 10;
current_best = zeros(grid_height,grid_width);
xrays = Ray.empty;
yrays = Ray.empty;
empty_tiles = grid_width*grid_height;

tile1 = Tile(1,1,20,1,1);
tile2 = Tile(2,2,40,2,2);
tile3 = Tile(3,3,50,20,3);
target1 = round(empty_tiles/3);
target2 = round(empty_tiles/3);
target3 = round(empty_tiles/3);
prev_merit = 10000;

for generated_plaques = 1:1
    plaque = zeros(grid_height,grid_width);

    %plaque = tile3.placelens(plaque, target3, 1000);
    [plaque, xrays,yrays] = tile3.placelens(plaque, target3, 1000, xrays,yrays);
%     [plaque, xrays,yrays] = tile2.placelens(plaque, target2, 1000, xrays,yrays);
%     [plaque, xrays,yrays] = tile1.placelens(plaque, 1000, 10000, xrays,yrays);



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
% for n = 1:length(xrays)
%     plot(xrays(n).xOrigin,xrays(n).yOrigin,'r*')
% end

figure(2);
clf(figure(2));
hold on;
xAngles = zeros(size(xrays));
yAngles = zeros(size(yrays));
for n = 1:length(xrays)
    xAngles(n) = xrays(n).xAngle*180/pi;
%     yAngles(n) = yrays(n).yAngle*180/pi;
end

h = histogram(xAngles, 361, 'BinLimits', [-90, 90]);
x = h.BinEdges;
x(end)=[];
x = x(h.BinCounts > 0);
y = h.BinCounts(h.BinCounts > 0);
plot(x,y)


%Currently looking into fitdist, trying to fit to cos^3(theta) where theta
%will have to be scaled to our desired spread, where the intensity equals
%zero when theta is 90degrees.
%Because the equation is Im*cos^3(theta*scaler)
modelFun = @(b)(b*cos(x*pi/110)^3);
beta0 = 1;
% t1 = array2table(xAngles);
% mdl = fitnlm(xAngles,modelFun,beta0);
