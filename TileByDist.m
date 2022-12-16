classdef TileByDist
    
    properties
        width
        height
        xFocus
        yFocus
        name
        area
        xSpread
        ySpread
    end

    methods
        function obj = TileByDist(width, height, xSpread, ySpread, name)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            obj.xFocus = width/2/tan(xSpread*pi/180);
            obj.yFocus = height/2/tan(ySpread*pi/180);
            obj.xSpread = xSpread;
            obj.ySpread = ySpread;
        end

        function [newPlaque, numberPlaced]  = placelens(this, plaque, idealarea, maxattempts)
        %setup of variables
        area_placed = 0;
        current_attempt = 0;
        newPlaque = plaque;
        [plaque_height, plaque_width] = size(newPlaque);
        numberPlaced = 0;
            while area_placed < idealarea && current_attempt < maxattempts
                current_attempt = current_attempt + 1;
                posx = randi(plaque_width-this.width-1,1) + 1;
                posy = randi(plaque_height-this.height-1,1) + 1;
                free_space = true;

                %Check the area is empty
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        if newPlaque(y,x) ~= 0
                            free_space = false;
                        end
                    end
                end
                if ~free_space
                    continue;
                end
                
                %Check directly around lens with buffer
                if this.area > 1
                    for y = posy - 1:posy + this.height
                        for x = posx - 1:posx + this.width
                            if newPlaque(y,x) == this.name
                                free_space = false;
                            end
                        end
                    end
                end
                if ~free_space
                    continue;
                end
                %Place lens
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        newPlaque(y,x) = this.name;
                    end
                end
                numberPlaced = numberPlaced + 1;
                area_placed = area_placed + this.area;

            end
        end
    end
end
