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
                        %Ray 1 is the ray in the center of the lens, it
                        %occurs at the center of the lens, which is already
                        %calculated
                        ray1 = Ray(posx + 0.5,posy + 0.5, 0, 0);
                        %Rays 2 and 3 are the (-x,0) and (x,0) positions,
                        %respectively. They occur at 
                        ray2 = Ray(posx, posy + 0.5, 0, 0);
                        ray3 = Ray(posx + 1,posy + .5, 0, 0);
                        %Rays 4 and 5 are the (0,-y) and (0,y) positions,
                        %respectively
                        ray4 = Ray(posx + 0.5, posy, 0, 0);
                        ray5 = Ray(posx + 0.5, posy + 1, 0, 0);
                        newRays = [newRays, ray1, ray2, ray3, ray4, ray5];
                    end
                end
                area_placed = area_placed + this.area;

                
                

                

            end
        end
    end
end

