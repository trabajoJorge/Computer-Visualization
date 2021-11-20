function main()
    % Creo la carpeta para guardar las soluciones.
    if exist('Solución', 'dir') rmdir('Solución', "s"); end
        mkdir Solución
        cd 'Solución'
    
    % Leo la imagen.
    img= imread('cameraman.tif');

    % fft2: debuelve la transformada de fourier bidimensional, utilizando el algoritmo de transformacion rapida de
    %       fourier.
    tf= fft2(img);

    % fftshift: reorganiza una transformada de Fourier X desplazando el componente de frecuencia cero al centro de la matriz.
    tfc= fftshift(img);

    

    cd .. 
end