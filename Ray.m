classdef Ray

    properties
        xOrigin
        yOrigin
        xAngle
        yAngle
        lens_position
    end
    
    methods
        function obj = Ray(xOrigin, yOrigin, xAngle, yAngle, corner)
            obj.xOrigin = xOrigin;
            obj.yOrigin = yOrigin;
            obj.xAngle = xAngle;
            obj.yAngle = yAngle;
            obj.lens_position = corner;
        end
        
    end
end

