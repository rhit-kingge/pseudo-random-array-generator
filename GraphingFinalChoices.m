RandomPlaque = readmatrix('Large fully random plaque values.xlsx');
TiledPlaque = readmatrix('Large tiled pattern - small tile repeated 4x4.xlsx');
figure(1)


x = length(RandomPlaque);
Random1 = zeros(x,x);Random2 = zeros(x,x);Random3 = zeros(x,x);Random4 = zeros(x,x);
Tiles1 = zeros(x,x);Tiles2 = zeros(x,x);Tiles3 = zeros(x,x);Tiles4 = zeros(x,x);


for column = 1:x
    for row = 1:x
        if RandomPlaque(column,row) == 1
            Random1(column,row) = 1;
        elseif RandomPlaque(column,row) == 2
            Random2(column,row) = 2;
        elseif RandomPlaque(column,row) == 3
            Random3(column,row) = 3;
        elseif RandomPlaque(column,row) == 4
            Random4(column,row) = 4;
        end
        if TiledPlaque(column,row) == 1
            Tiles1(column,row) = 1;
        elseif TiledPlaque(column,row) == 2
            Tiles2(column,row) = 2;
        elseif TiledPlaque(column,row) == 3
            Tiles3(column,row) = 3;
        elseif TiledPlaque(column,row) == 4
            Tiles4(column,row) = 4;
        end
    end
end

imagesc(RandomPlaque);
title("Fully Random Plaque");
axis off

figure(2)
% imagesc(TiledPlaque);
% title("Plaque Made with 10mmx10mm Repeating Tiles")

imagesc(Random1);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]); %title("Random Plaque Tile 1");axis off;
figure(3)
imagesc(Random2);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Random Plaque Tile 2");axis off;
figure(4)
imagesc(Random3);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Random Plaque Tile 3");axis off;
figure(5)
imagesc(Random4);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Random Plaque Tile 4");axis off;
figure(6)
imagesc(Tiles1);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Patterned Plaque Tile 1");axis off;
figure(7)
imagesc(Tiles2);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Patterned Plaque Tile 2");axis off;
figure(8)
imagesc(Tiles3);colormap('gray');set(axes,'position',[1 1 0 0])%axes('Position', [1 1 0 0]);%title("Patterned Plaque Tile 3");axis off;
figure(9)
imagesc(Tiles4);colormap('gray');set(axes,'position',[1 1 0 0])%axis off;axes('Position', [1 1 0 0]);
