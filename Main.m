clc; clear all;

n = 1.4926;     %Refractive index of PMMA according to refractiveindex.info
theta = 45*pi/180;  %Output angle, technically working in reverse
NA = n*sin(-theta);      %The numerical aperture of a PMMA lens with a 45 degree output
D = 0.2:0.01:0.5;
R2 = -1.055*D./(n-1);


%The process here is to create an array that represents either one tile in
%the pattern or the whole plaque. Each square in the 2D array represents a
%square of 0.2mm currently (easier to downgrade later if needed). The loop
%selects a random location, checks if it can place the desired tile there,
%places it there if it can and tries 3(?) other places if it cannot. Then
%it moves on to the next kind of tile. When there are less than a certain
%(undetermined) amount of spaces left, the program fills them with the
%smaller tiles.
%For checking the positioning, to work with MATLAB the code should check
%from the top left corner. So for example a tile that takes up 2x2 squares
%will choose an index and check the squares to the right, below, and
%diagonal down-right. This will also mean larger plaques should only check
%indexes in a smaller range to avoid indexing errors.

gridx = 20;
gridy = 20;
current_best = zeros(gridx,gridy);
empty_tiles = gridx*gridy;
tile1 = 1;
tile2 = 2;
tile3 = 3;

each_area = empty_tiles/3;

number_1 = round(each_area/(tile1^2));
number_2 = round(each_area/(tile2^2));
number_3 = round(each_area/(tile3^2));
%I think the approach should be to place all the large tiles first, then go
%down in size for better distribution. If we assume even distribution,
%Maybe they most 
prev_merit = 10000;

for attempts = 1:10
    n1 = 0; n2 = 0; n3 = 0;
    plaque = zeros(gridx,gridy);
    tries = 0;
    while n3 < number_3 && tries < 100000
        number_filled = 0;
        posx = randsample(gridx-tile3-1,1) + 1;
        posy = randsample(gridy-tile3-1,1) + 1;
        for x = posx-1:posx + tile3
            for y = posy-1: posy + tile3
                number_filled = number_filled + plaque(x,y);
            end
        end
        if number_filled == 0
            for x = posx:posx + tile3 - 1
                for y = posy: posy + tile3 - 1
                    plaque(x,y) = tile3;
                end
            end
            n3 = n3 + 1;
        end
        tries = tries + 1;
    end
    tries = 0;
    while n2 < number_2 && tries < 100000
        number_filled = 0;
        posx = randsample(gridx-tile2-1,1) + 1;
        posy = randsample(gridy-tile2-1,1) + 1;
        for x = posx:posx + tile2 - 1
            for y = posy-1: posy + tile3 -1
                number_filled = number_filled + plaque(x,y);
            end
        end
        if number_filled == 0
            for x = posx:posx + tile2 - 1
                for y = posy: posy + tile2 - 1
                    plaque(x,y) = tile2;
                end
            end
            n2 = n2 + 1;
        end
        tries = tries + 1;
    end
    for x = 2:gridx-1
        for y = 2:gridy-1
            if plaque(x,y) == 0
                plaque(x,y) = tile1;
            end
        end
    end
    %Merit function
    merit = sqrt((number_3-n3)^2+(number_2-n2)^2);
    if merit < prev_merit
        current_best = plaque;
        prev_merit = merit;
    end

end


imagesc(current_best);
