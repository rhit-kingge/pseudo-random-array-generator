classdef Tile
    %TILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        width
        height
        radius
        area
        buffer
    end

    %potential tracing method: Code sends rays through random indices of
    %the array, then activates a method of the intercepted tile. Because
    %the tiles have different sizes an xheight and yheight can be generated
    %for the ray, then because the light is collimated it will focus at the
    %focal point of the lens, allowing us to calculate an output angle.

    methods
        function obj = Tile(width, height, radius)
            obj.width = width;
            obj.height = height;
            obj.radius = radius;
            obj.area = width*height;
            if obj.area == 1
                buffer = 0;
            else
                buffer = 1;
            end
        end

        function obj = placelens(this, plaque, idealarea, maxattempts)
        area_placed = 0;
        current_attempt = 0;
        [plaque_height, plaque_width] = size(plaque);
        obj = plaque;
            while area_placed < idealarea && current_attempt < maxattempts
                current_attempt = current_attempt + 1;
                posx = randi(plaque_width-this.width-1,1) + 1;
                posy = randi(plaque_height-this.height-1,1) + 1;
                free_space = true;
        
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        if obj(y,x) ~= 0
                            free_space = false;
                        end
                    end
                end
                if ~free_space
                    continue;
                end
        
                for y = posy - this.buffer:posy + this.height
                    for x = posx - this.buffer:posx + this.width
                        if obj(y,x) == this.radius
                            free_space = false;
                        end
                    end
                end
                if ~free_space
                    continue;
                end
        
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        obj(y,x) = this.radius;
                    end
                end
                area_placed = area_placed + this.area;        
            end
        end
    end
end

