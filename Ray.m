classdef Ray

    properties
        xOrigin
        yOrigin
        xAngle
        yAngle
    end
    
    methods
        function obj = Ray(xOrigin, yOrigin, xAngle, yAngle)
            obj.xOrigin = xOrigin;
            obj.yOrigin = yOrigin;
            obj.xAngle = xAngle;
            obj.yAngle = yAngle;
        end
        
    end
end

