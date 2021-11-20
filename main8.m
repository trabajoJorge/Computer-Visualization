
%Guardo las imágenes de las hojas.
imagenes = imageDatastore('BD_Hojas');
imagenes = readall(imagenes);

for i=1:size(imagenes)
    % Modifico el tamaño de las imagenes, para que de esta manera todas tengan el mismo.
    % Las pongo en escLala de imagenes y las pongo en un vector fila.
    imagenes{i} = imresize(imagenes{i},[1206,697]);
    imagenes{i} = rgb2gray(imagenes{i});
    imagenes{i} = reshape(imagenes{i},1, []);
end;

% Agrupo todos los vectores para convertirlos en una matriz donde cada fila es una imagen. 
matrizImagenes = cell2mat(imagenes);

% Creamos un vector columna con las etiquetas de las imagenes. Siendo las 75 primeras de un tipo (0)
% y las 75 siguientes de otro.
tipos = cat(1,zeros(75,1), ones(75,1));

% Hago su transpuesta, ya que con ella obtengo un mejor resultado.
matrizImagenes= im2double(matrizImagenes);
matrizImagenes = matrizImagenes';

% Realizo PCA para reducir las dimensiones, menos utilizadas.
coficiente = pca(matrizImagenes);


