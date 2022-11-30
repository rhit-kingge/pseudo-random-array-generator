function obj = placeTile(tile, ideal_area, plaque, max_attempts)


area_placed = 0;
current_attempt = 0;
[plaque_height, plaque_width] = size(plaque);
obj = plaque;
% plaque_width = colnum - 2;
% plaque_height = rownum - 2;

    while area_placed < ideal_area && current_attempt < max_attempts

        current_attempt = current_attempt + 1;
        posx = randi(plaque_width-tile.width-1,1) + 1;
        posy = randi(plaque_height-tile.height-1,1) + 1;
        free_space = true;

        for x = posx:posx + tile.width - 1
            for y = posy: posy + tile.height - 1
                if obj(y,x) ~= 0
                    free_space = false;
                end
            end
        end
        if ~free_space
            continue;
        end
        fprintf("A space is empty " + free_space + "\n")

        for y = posy - 1:posy + tile.height
            for x = posx - 1:posx + tile.width
                if obj(y,x) == tile.radius
                    free_space = false;
                end
            end
        end
        if ~free_space
            continue;
        end
        fprintf("The buffer arount the space is also free of this tile " + free_space + "\n")

        for x = posx:posx + tile.width - 1
            for y = posy: posy + tile.height - 1
                obj(y,x) = tile.radius;
            end
        end
        area_placed = area_placed + tile.area;
        fprintf("The tile has been placed " + free_space + "\n")

    end

end

