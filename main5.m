function main()
    % Creo la carpeta para guardar las soluciones.
    if exist('Solución', 'dir') rmdir('Solución', "s"); end
        mkdir Solución
    
    % Leo la imagen
    img = imread('lena_std.tif');
    
    % Paso la imagen a escala de grises
    imgGray=rgb2gray(img); 
    
    % TODO: Entender bien la funcion
    % fspecial: devuelve un laplacio rotacionalmente simétrico de filtro gaussiano de tamaño hsize con desviación estándar. Creo que es el filtro
    % hsize: tamaño del filtro gausiano
    % sigma: Desviación estándar, especificada como un número positivo.
    sigma=7;
    hsize= 8*sigma;
    filtro=fspecial('log',hsize,sigma);

    % filter2: devuelve la la imagen despues de aplicarle el filtro. Obteniendo así el resultado  con la escala de grises ajustada al máximo valor.
    % filtro: filtro a aplicar a la imagen
    % imgGray: imagen a la que se aplica el filtro
    imgFiltrada=filter2(filtro,imgGray,'full');
    
    % Valor absoluto
    imgFiltradaABS= abs(imgFiltrada);

    % Escribo las soluciones
    cd Solución
        imwrite(imgFiltrada, 'imgFiltrada.jpg');
        imwrite(imgFiltradaABS, 'imgFiltradaABS.jpg')
    
    cd ..
end