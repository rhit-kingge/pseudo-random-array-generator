%This code was written by Aerin King, Cody Brelage, and Andy Krajecki in
%association with the Rose-Hulman Department of Physics and Optical
%Engineering. 

%To start, set your smallest element dimension, number of unique elements, and the size of the plaque
%you intend to design. The size of the plaque must be a multiple of the
%smallest element dimension, and they must have the same units (both in mm,
%in...). The smallest element must also be square.
smallest_element_dimension = 0.5;
number_of_unique_elements = 4;
plaque_width = 10;
plaque_height = 10;

%These lines convert the plaque dimensions to array lengths and set up data
%storage
grid_width = plaque_width/smallest_element_dimension;
grid_height = plaque_height/smallest_element_dimension;
plaque = zeros(grid_height + 2,grid_width + 2);
elements = TileByDist.empty;
elementCounts = zeros(number_of_unique_elements,1);

%This section defines the tiles that will be placed on the plaque. At the
%time of writing this code, there are two types of elements that can be
%placed, lenses and rough surface patches. Constructing a lens looks like
%this: 
%elements(X) = TileByDist(X, true/false,width/smallest_element_dimension,height/smallest_element_dimension,"Lens", xSpread, ySpread) Here the true/false represents if you want the
%lens to be rotatable (placed in both orientations if it's a rectangle),
%and xSpread and ySpread are the desired angular distribution of the lens
%output.
%Constructing a tile with a surface roughness looks like this:
%elements(X) = TileByDist(X, true/false, width/smallest_element_dimension,height/smallest_element_dimension, "Rough Surface", rms_surface_roughness)
%Where true/false again represents rotatability. More information on these
%constructors can be found within the TileByDist class file.
%Note that tile 1 must always have height and width of 1 and must be defined as elements(1).
elements(1) = TileByDist(1,false,1,1,"Rough Surface",1500);
elements(2) = TileByDist(2,true,1/smallest_element_dimension,.5/smallest_element_dimension,"Rough Surface",1000);
elements(3) = TileByDist(3,true,1.5/smallest_element_dimension,.5/smallest_element_dimension,"Rough Surface",1000);
elements(4) = TileByDist(4,true,1.5/smallest_element_dimension,1/smallest_element_dimension,"Rough Surface",1000);


%This section handles placing the elements on the plaque. As long as tiles
%have been defined correctly, this section should never need to be changed.
for n = 1:number_of_unique_elements-1
    [plaque, elementCounts(number_of_unique_elements + 1 - n)] = elements(number_of_unique_elements + 1 - n).placeElement(plaque);
end
[x,y] = find(plaque(2:grid_height + 1,2:grid_width + 1)==0);
elementCounts(1) = length(x);
for n = 1:length(x)
    plaque(x(n) + 1,y(n) + 1) = 1;
end
xInAngles = -35*pi/180:.005:35*pi/180; %These boundaries can be edited to the desired angular range

%This section gets the output distribution from each tile and
%adds them together for a total output. This section also should not need
%to be changed.
xOutputs = zeros(number_of_unique_elements,length(xInAngles));
for n = 1:number_of_unique_elements
    xOutputs(n,:) = elementCounts(n)*elements(n).getDistribution(xInAngles)./(length(plaque)^2);
end
totalXOutput = sum(xOutputs,1);

% Figure 1 plots the contribution from each element type individually,
% figure 3 plots the total expected output distribution, figure 3 provides
% a visual representation of the plaque.
figure(1)
clf(figure(1));
hold on
for n = 1:number_of_unique_elements
    plot(xInAngles*180/pi, xOutputs(n,:))
end
xlabel("Angle from Surface Normal (degrees)");ylabel("Relative Output Intensity of Each Element Type (summed)");

figure(2)
plot(xInAngles*180/pi,totalXOutput,"r");
xlabel("Angle from Surface Normal (degrees)");ylabel("Intensity");

figure(3)
imagesc(plaque); axis off;




