classdef Tile
    %TILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        width
        height
        radius
        area
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
        end
        
        
    end
end

