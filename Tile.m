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
        function obj = Tile(width, height, xRadius, yRadius, name)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            obj.xFocus = xRadius/(1.4936-1);
            obj.yFocus = yRadius/(1.4936-1);
        end

        function [newPlaque, newRays]  = placelens(this, plaque, idealarea, maxattempts, rays)
        %setup of variables
        area_placed = 0;
        current_attempt = 0;
        newRays = rays;
        newPlaque = plaque;
        [plaque_height, plaque_width] = size(newPlaque);
        
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
        

                %If the space is empty and there are no like tiles next to
                %the space, this loop places the tile. The next line
                %updates the area taken up by the current kind of lens for
                %the distribution target.
                xCenter = posy + this.width/2;
                yCenter = posx + this.height/2;
                %This is the loop that actually changes each square, so for
                %the 3x3 lens it goes through all 9 spaces. Here is where
                %the rays should be made, since they shhould be made for
                %every space
                for x = posx:posx + this.width - 1
                    for y = posy: posy + this.height - 1
                        newPlaque(y,x) = this.name;

                        centerRay = Ray(x + 0.5,y + 0.5, -atan((x - xCenter + 0.5)/this.xFocus), -atan((y - yCenter + 0.5)/this.yFocus), [x y]);
                        newRays(end + 1) = centerRay;
% 
%                         leftRay = Ray(x, y + 0.5, -atan((x - xCenter)/this.xFocus), -atan((y - yCenter + 0.5)/this.yFocus), [x y]);
%                         rightRay = Ray(x, y - .5, -atan((x + 1 - xCenter)/this.xFocus), -atan((y - yCenter + 0.5)/this.yFocus), [x y]);
% 
%                         bottomRay = Ray(x + 0.5, y+1, -atan((x - xCenter + 0.5)/this.xFocus), -atan((y - yCenter)/this.yFocus), [x y]);
%                         topRay = Ray(x + 0.5, y, -atan((x - xCenter + 0.5)/this.xFocus), -atan((y - yCenter + 1)/this.yFocus), [x y]);
%                         
%                         newRays = [newRays, centerRay, leftRay, rightRay, bottomRay, topRay];
                    end
                end
                area_placed = area_placed + this.area;

            end
        end
    end
end

