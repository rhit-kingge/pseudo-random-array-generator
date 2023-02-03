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
        scatterRatio
        %roughness

    end

    methods

        function obj = TileByDist(name, width, height, varargin)
            obj.width = width;
            obj.height = height;
            obj.name = name;
            obj.area = width*height;
            
            obj.scatterRatio = 0;
            obj.xSpread = 0;
            obj.ySpread = 0;
            
            obj.elementType = varargin{1};
            if varargin{1} == "Lens"
                obj.xSpread = varargin{2};
                obj.ySpread = varargin{3};
                obj.elementType = varargin{1};
            end
            if varargin{1} == "Rough Surface"
                obj.scatterRatio = varargin{2};
                obj.elementType = varargin{1};
            end
        end

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

        function obj = getDistribution(this, angles)
            if this.elementType == "Lens"
                obj = this.area*exp(-2*(tan(angles)/(2*this.xSpread*pi/180)).^2);
            end
            if this.elementType == "Rough Surface"
%                 fprintf("The element is a rough surface and this part at least is running correctly")
%                 scatter = 100;
                reflectance = 0.08;
                centerWavelength = 600;
                %I'm going to make a few minor assumptions for the moment,
                %with respect to Reflectance and index of the material.
%                 collimatedComponent = this.area*exp(-2*(tan(angles)/(5*pi/180/2)).^2);
                percentScatter = reflectance*(1-exp(-(4*pi*this.scatterRatio/centerWavelength)^2));
                obj = this.area*percentScatter*cos(angles) + this.area*(1-percentScatter)*exp(-2*(tan(angles)/(10*pi/180)).^2);
%                 obj = this.area*(1-reflectance)*(1-percentScatter) + percentScatter.*cos(angles);

                %Thought process: The beam of light through a glass plate
                %is the incoming intensity times (one minus the surface
                %reflectance) squared. The second surface reflection is
                %what we care about, but it wont be reflected it will be
                %scattered. The scattered light will follow cos(theta) with
                %normal again being zero, and the rest of the light will
                %just continue straight. According to TISbp -total
                %integrated scatter- = R0*(1-e^(-(4pi*Rqcos(theta)^2)). Rq
                %is rms surface roughness, theta is incident angle, and
                %lambda is the central wavelength. The output is then
                %I*.96*1-TIS + TIS*cos(theta)

            end
            if this.elementType == "Cosine Power"
                obj = zeros(size(angles));
            end
        end


    end
end
