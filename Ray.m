classdef Ray

    properties
        xOrigin
        yOrigin
        xAngle
        yAngle
        lens_center
    end
    
    methods
        function obj = Ray(xOrigin, yOrigin, xAngle, yAngle, center)
            obj.xOrigin = xOrigin;
            obj.yOrigin = yOrigin;
            obj.xAngle = xAngle;
            obj.yAngle = yAngle;
            obj.lens_center = center;
        end
        
    end
end

