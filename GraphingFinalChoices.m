clc; clear all;
RandomPlaque = readmatrix('Large fully random plaque values.xlsx');
TiledPlaque = readmatrix('Large tiled pattern - small tile repeated 4x4.xlsx');
figure(1)


x = length(RandomPlaque);
Random1 = zeros(x,x) + 1;Random2 = zeros(x,x) + 1;Random3 = zeros(x,x) + 1;Random4 = zeros(x,x) + 1;
Tiles1 = zeros(x,x) + 1;Tiles2 = zeros(x,x) + 1;Tiles3 = zeros(x,x) + 1;Tiles4 = zeros(x,x) + 1;


for column = 1:x
    for row = 1:x
        if RandomPlaque(column,row) == 1
            Random1(column,row) = 0;
        elseif RandomPlaque(column,row) == 2
            Random2(column,row) = 0;
        elseif RandomPlaque(column,row) == 3
            Random3(column,row) = 0;
        elseif RandomPlaque(column,row) == 4
            Random4(column,row) = 0;
        end
        if TiledPlaque(column,row) == 1
            Tiles1(column,row) = 0;
        elseif TiledPlaque(column,row) == 2
            Tiles2(column,row) = 0;
        elseif TiledPlaque(column,row) == 3
            Tiles3(column,row) = 0;
        elseif TiledPlaque(column,row) == 4
            Tiles4(column,row) = 0;
        end
    end
end

imagesc(RandomPlaque);
title("Fully Random Plaque");
axis off

figure(2)
imagesc(Random1);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(3)
imagesc(Random2);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(4)
imagesc(Random3);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(5)
imagesc(Random4);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(6)
imagesc(Tiles1);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(7)
imagesc(Tiles2);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(8)
imagesc(Tiles3);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));

figure(9)
imagesc(Tiles4);
colormap('gray'); axis off; set(gca, 'DataAspectRatio', [1 1 1]);set(gca, 'Position', [0 0 1 1]);
set(gcf, 'PaperPosition', get(gca, 'Position'));
