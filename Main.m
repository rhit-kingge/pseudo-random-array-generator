clc; clear all;

% n = 1.4926;     %Refractive index of PMMA according to refractiveindex.info
% theta = 45*pi/180;  %Output angle, technically working in reverse
% NA = n*sin(-theta);      %The numerical aperture of a PMMA lens with a 45 degree output
% D = 0.2:0.01:0.5;
% R2 = -1.055*D./(n-1);


%The process here is to create an array that represents either one tile in
%the pattern or the whole plaque. Each square in the 2D array represents a
%square of 0.2mm currently (easier to downgrade later if needed). The loop
%selects a random location, checks if it can place the desired tile there,
%places it there if it can and tries other places if it cannot. It tries to
%place the tile until a desired number of that tile or until a set number of attempts.
%It does this first with the largest tile, then the second largest, then it
%fills in the rest of the gaps with the smallest tile.
%For checking the positioning, to work with MATLAB the code should check
%from the top left corner. So for example a tile that takes up 2x2 squares
%will choose an index and check the squares to the right, below, and
%diagonal down-right. This will also mean larger plaques should only check
%indexes in a smaller range to avoid indexing errors.


grid_width = 20;
grid_height = 20;
current_best = zeros(grid_height,grid_width);
empty_tiles = grid_width*grid_height;

tile1 = Tile(1,1,1);
tile2 = Tile(2,2,2);
tile3 = Tile(3,3,3);
target1 = round(empty_tiles/3);
target2 = round(empty_tiles/3);
target3 = round(empty_tiles/3);
prev_merit = 10000;

for generated_plaques = 1:2
    plaque = zeros(grid_height,grid_width);
    plaque = placeTile(tile3, target3, plaque, 10000);
    plaque = placeTile(tile2, target2, plaque, 10000);

    for x = 2:grid_width-1
        for y = 2:grid_height-1
            if plaque(x,y) == 0
                plaque(x,y) = tile1.radius;
            end
        end
    end

    %Merit function
%     merit = sqrt((target3-n3)^2+(target2-n2)^2);
%     if merit < prev_merit
%         current_best = plaque;
%         prev_merit = merit;
%     end

end


imagesc(current_best);
