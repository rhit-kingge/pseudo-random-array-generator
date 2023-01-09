classdef TileByDist
    
    properties
        width
        height
        name
        area
        elementType

        %Lenses only
        xSpread
        ySpread

        %Etched surfaces anyway
        spread
        roughness

    end

    methods

        function obj = TileByDist(name, width, height, varargin)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            
            obj.spread = 0;
            obj.xSpread = 0;
            obj.ySpread = 0;
            
            obj.elementType = varargin{1};
            if varargin{1} == "Lens"
                obj.xSpread = varargin{2};
                obj.ySpread = varargin{3};
                obj.elementType = varargin{1};
            end
            if varargin{1} == "Rough Surface"
                obj.spread = varargin{2};
                obj.elementType = varargin{1};
            end

        end
%         function obj = LensByDist(width, height, xSpread, ySpread, name)
%             obj.width = width;
%             obj.height = height;
%             obj.name = name;
%             obj.area = width*height;
%             obj.xSpread = xSpread;
%             obj.ySpread = ySpread;
%         end
% 
%         function obj = roughSurface(width, height, spread, name)
%             obj.width = width;
%             obj.height = height;
%             obj.name = name;
%             obj.area = width*height;
%             obj.spread = spread;
%         end


        function [newPlaque, numberPlaced]  = placeElement(this, plaque, maxattempts)
        %setup of variables
        newPlaque = plaque;
        [plaque_height, plaque_width] = size(newPlaque);
        newPlaque_area = (plaque_height - 2)*(plaque_height - 2);
        if this.area > 1
            idealNumber = round(newPlaque_area/3/this.area);
        else
            idealNumber = 1000;
        end

        numberPlaced = 0;
        current_attempt = 0;
            while numberPlaced < idealNumber && current_attempt < maxattempts
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

            end
        end
    end
end
