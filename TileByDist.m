classdef TileByDist
    
    properties
        %These properties will be present for every tile:
        width
        height
        name
        area
        elementType
        rotatable

        %These properties are specific to each type of element. If you want
        %to add another type of element model, first comment which type of
        %element you are making then state every property that the element
        %needs to store.

        %Lens
        xSpread
        ySpread

        %Surface Roughness
        roughness

    end

    methods
        %This is the constructor function. Fisrt it assigns all usiversal
        %properties, then the properties specific to the element type. When
        %adding a new element type, follow the examples below. varargin{1}
        %should always be the name of the element, and the varargin indeces
        %should be element-specific properties.
        function obj = TileByDist(name, rotatable, width, height, varargin)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            obj.rotatable = rotatable;
            obj.elementType = varargin{1};
            %The above code should not be altered when adding a new element
            %type, if a new type is added it sould be a new else if
            %statement below.
            if varargin{1} == "Lens"
                obj.xSpread = varargin{2};
                obj.ySpread = varargin{3};
                obj.elementType = varargin{1};
            elseif varargin{1} == "Rough Surface"
                obj.roughness = varargin{2};
                obj.elementType = varargin{1};
            end
        end

        %This function places the elements on the plaque that is passed in
        %from the main file. It only deals with tile placement, and should
        %not be changed unless it is desired to have a different plaque generation
        %method.
        function [newPlaque, numberPlaced]  = placeElement(this, plaque)
        %Setup variables
        newPlaque = plaque;
        [plaque_height, plaque_width] = size(newPlaque);
        newPlaque_area = (plaque_height-2)*(plaque_height-2);
        idealNumber = round(newPlaque_area/4/this.area);
        numberPlaced = 0;
        current_attempt = 0;

        %This while loop continues while the number of tiles placed is less
        %than the "ideal" number and while less than 100,000 attempts have
        %been made. The maximum number of attempts allows the program to
        %move on when the ideal number has not been placed but there are no
        %more available positions, which would otherwise cause an infinite
        %loop. This number can be raised to get closer to the ideal number
        %of tiles, or lowered to reduce runtime.
            while numberPlaced < idealNumber && current_attempt < 100000
                free_space = true;
                xspan = this.width;
                yspan = this.height;
                current_attempt = current_attempt + 1;

                %This statement handles rotation if applicable:
                if this.rotatable
                    if randi(2,1) == 2
                        xspan = this.height;
                        yspan = this.width;
                    end
                end
                
                %These lines select a random location on the plaque
                posx = randi(plaque_width-xspan-1,1) + 1;
                posy = randi(plaque_height-yspan-1,1) + 1;
                
                %This statement checks that the random location does not
                %already have a tile
                for x = posx:posx + xspan - 1
                    for y = posy: posy + yspan - 1
                        if newPlaque(y,x) ~= 0
                            free_space = false;
                        end
                    end
                end
                if ~free_space
                    continue;
                end

                %This statement checks that the tile will not be directly
                %adjacent to another tile of the same type, it is not
                %essential and can be commented out if desired.
                for y = posy - 1:posy + yspan
                    for x = posx - 1:posx + xspan
                        if newPlaque(y,x) == this.name
                            free_space = false;
                        end
                    end
                end
                if ~free_space
                    continue;
                end
                
                %Once the area has been checked, this statement places the
                %tile.
                for x = posx:posx + xspan - 1
                    for y = posy: posy + yspan - 1
                        newPlaque(y,x) = this.name;
                    end
                end
                numberPlaced = numberPlaced + 1;
            end
        end

        %This function calculates and returns the output distribution of a
        %single element. If writing a new element, a new if statement
        %should be written that calculates the intensity as a function of
        %the given angles in radians.
        function obj = getDistribution(this, angles)
            if this.elementType == "Lens"
                obj = this.area*exp(-2*(tan(angles)/(2*this.xSpread*pi/180)).^2);
            end
            if this.elementType == "Rough Surface"
                reflectance = 0.08;
                centerWavelength = 600;
                percentScatter = reflectance*(1-exp(-(4*pi*this.roughness/centerWavelength)^2));
                obj = this.area*percentScatter*cos(angles) + this.area*(1-percentScatter)*exp(-2*(tan(angles)/(10*pi/180)).^2);
            end
        end

    end
end
