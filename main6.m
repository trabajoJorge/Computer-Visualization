function main()

    % Creo la carpeta para guardar las soluciones.
    if exist('Solución', 'dir') rmdir('Solución', "s"); end
        mkdir Solución
    
    % Leo la imagen.
    img = imread('input.jpg');
    
    % Paso la imagen a escala de grises.
    imgGray=rgb2gray(img);
    
    % edge: detecta los bordes de la imagen mediante el algoritmo de detección de bordes especificado.
    % imgGray: imagen a procesar. Tiene que estar en escala de grises si no da error.
    % sobel: Metodo de deteccion de bordes que encuentra bordes en aquellos puntos donde el degradado de la imagen es máximo.
    imgBordes = edge(imgGray, 'sobel');
    
    % Escribo las soluciones.
    cd Solución
        imwrite(imgBordes, 'solución.jpg');
    cd ..
    
end
