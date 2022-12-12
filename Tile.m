classdef Tile

    properties
        width
        height
        xFocus
        yFocus
        name
        area
    end

    methods
        function obj = Tile(width, height, xSpread, ySpread, name)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            obj.xFocus = width/2/tan(xSpread*pi/180);
            obj.yFocus = height/2/tan(ySpread*pi/180);
        end

        function [newPlaque, newRays]  = placelens(this, plaque, idealarea, maxattempts, rays)
        %setup of variables
        area_placed = 0;
        current_attempt = 0;
        newRays = rays;
        newPlaque = plaque;
        [plaque_height, plaque_width] = size(newPlaque);
        lenses_placed = 0;
            while area_placed < idealarea && current_attempt < maxattempts
                current_attempt = current_attempt + 1;
                posx = randi(plaque_width-this.width-1,1) + 1;
                posy = randi(plaque_height-this.height-1,1) + 1;
                free_space = true;

                %This loop checks the generated location to make sure no
                %other lens is already placed there
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
                
                %If the space is empty and the tile is not the smallest tile, this checks the adjacent
                %spaces to make sure the tile is not being placed
                %by a matching tile
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
                
                xCenter = posx + (this.width-1)/2;
                yCenter = posy + (this.height-1)/2;
                rayCounter = 0;
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        newPlaque(y,x) = this.name;
                        

                        centerRay = Ray(x, y, atan((x - xCenter)/this.xFocus), atan((y - yCenter)/this.yFocus), [xCenter yCenter]);
                        leftRay = Ray(x - 0.5, y, atan((x - 0.5 - xCenter)/this.xFocus), atan((y - yCenter)/this.yFocus), [xCenter yCenter]);
                        rightRay = Ray(x + 0.5, y, atan((x + 0.5 - xCenter)/this.xFocus), atan((y - yCenter)/this.yFocus), [xCenter yCenter]);
                        bottomRay = Ray(x, y - 0.5, atan((x - xCenter)/this.xFocus), atan((y - 0.5 - yCenter)/this.yFocus), [xCenter yCenter]);
                        topRay = Ray(x, y + 0.5, atan((x - xCenter)/this.xFocus), atan((y - yCenter + 0.5)/this.yFocus), [xCenter yCenter]);

                        newRays(end + 1) = centerRay;
                        newRays(end + 1) = leftRay;
                        newRays(end + 1) = rightRay;
                        newRays(end + 1) = bottomRay;
                        newRays(end + 1) = topRay;
                        rayCounter = rayCounter + 5;
                    end
                end
%                 lenses_placed = lenses_placed + 1;
%                 fprintf("The total number of lenses placed currently is: " + lenses_placed + "\n")
%                 fprintf("The number of rays placed for this whole lens was: " + rayCounter + "\n")
%                 fprintf("The total number of rays created is: " + length(newRays) + "\n")
%                 fprintf("-----------------------------------------------------------------------\n")
                area_placed = area_placed + this.area;

            end
        end
    end
end

