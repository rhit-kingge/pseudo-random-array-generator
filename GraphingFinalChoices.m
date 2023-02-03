RandomPlaque = readmatrix('Large fully random plaque values.xlsx');
TiledPlaque = readmatrix('Large tiled pattern - small tile repeated 4x4.xlsx');
figure(1)
imagesc(RandomPlaque);
title("Fully Random Plaque");

figure(2)
imagesc(TiledPlaque);
title("Plaque Made with 10mmx10mm Repeating Tiles")