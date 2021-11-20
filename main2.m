function main()
    % Base del proyecto recogida del codigo de ejemplo dado por el docente (codigoEjemplo.m)
    % Los resultados obtenidos se alojaran en la carpeta solciones.

    % Recogo los datos para su procesamiento

    % Guardo los datos de dir para posteriormente acceder mas facilmente al nombre de los archivos
    % Dir es un struct que recoge los datos de la carpeta. Tambíen se utiliza como comando.
    cd resultados
    d=dir;
    cd .. 

    % Guardo todas las imagenes de la carpeta resultados en un array
    imagenes = readall(imageDatastore('resultados'));

    % Creo la carpeta para guardar las soluciones
    if exist('Solución', 'dir') rmdir('Solución', "s"); end
    mkdir Solución
    cd 'Solución'
    
    % Creo las subcarpetas para recoger las distintas soluciones
    mkdir resultados1
    mkdir resultados2
    mkdir resultados3
    mkdir resultados4

    for i=1:size(imagenes,1)
        % --- CARPETA INICIAL
        img=imagenes{i};

        % --- RESULTADOS 1
        cd 'resultados1'
        
        % img: imagen a procesar.
        % ones: crea una matriz cuadrada de 1s con el parametro dado. En este caso representa la ventana.
        % imclose: realiza la operacion mofologica de cierre. La operación consiste en una dilatación seguida
        %          de una erosion, utilizando el mismo elemento estructural para ambas operaciones.  
        bw1=imclose(img, ones(3));
        
        % Escribo la imagen
        imwrite(bw1,d(i+2).name)
        
        % --- RESULTADOS 2
        cd ../'resultados2'
        
        % img: imagen a procesar.
        % ones: crea una matriz cuadrada de 1s con el parametro dado. En este caso representa la ventana.
        % imopen: realiza la operacion mofologica de apertura. La operación consiste en una erosion seguida
        %          de una dilatacion, utilizando el mismo elemento estructural para ambas operaciones.  
        bw2=imopen(img, ones(3));
        
        % Escribo la imagen
        imwrite(bw2,d(i+2).name)
        
        % --- RESULTADOS 3
        cd ../'resultados3'

        % img: imagen invertida.
        % ones: crea una matriz cuadrada de 1s con el parametro dado. En este caso representa la ventana.
        % imclose: realiza la operacion mofologica de cierre.
        aux= imclose(1-img, ones(5)); 
        
        % aux: Imagen sobre la que se aplica la accion.
        % remove: funcion a realizar n veces hasta que la imagen no sufra cambios. Elimina los pixeles interiores unicamente dejando el contorno de los objetos.
        aux2= bwmorph(aux, 'remove', Inf); 
        
        % La imagen resultante es un contorno blanco y lo demas en negro.
        % Por ello hago su inverso. Obteniendo la imagen en blanco y contorno negro.
        bw3= 1-aux2; 

        % Escribo la imagen
        imwrite(bw3,d(i+2).name)
        
        % --- RESULTADOS 4
        cd ../'resultados4'
        % img: imagen invertida.
        % ones: crea una matriz cuadrada de 1s con el parametro dado. En este caso representa la ventana.
        % imclose: realiza la operacion mofologica de cierre.
        aux= imclose(1-img, ones(5));
        
        % aux: Imagen sobre la que se aplica la accion.
        % skel: funcion a realizar n veces hasta que la imagen no sufra cambios. Devuelve el esqueleto de la imagen
        bw4= bwmorph(aux, 'skel', Inf);

        % Escribo la imagen
        imwrite(bw4,d(i+2).name);
        cd ..
    end

    cd ..

end