function main()

    % Creo la carpeta para guardar las soluciones
    if exist('Solución', 'dir') rmdir('Solución', "s"); end
    mkdir Solución
    cd 'Solución'
    
    % Leo la imagen. NOTA: rice.png es una imagen predefinida en matlab.
    img= imread('rice.png');

    % Paso la imagen por un filtro con el objetivo de separar el fondo y los granos de arroz.
    
    img= imerode(img>120, ones(1));
    % img: imagen filtrada separando parte del fondo y arroz.
    % ones(1): ventana de 1 utilizada para la erosion.
    % imerode: erosiona la imgen.

    % Queda con algo de ruido por lo que hago una apertura.
    img= imopen(img, ones(3));
    %imopen: realiza la operacion mofologica de apertura. La operación consiste en una erosion seguida
    %        de una dilatacion, utilizando el mismo elemento estructural para ambas operaciones.  
    
    % Obtengo los componenetes de la imagen. Componente se en
    % bwlabel: devuelve el numero y los objetos conectados
    [comp,ncomp]=bwlabel(img); 
    
    % Creo la lista para guardar la estructura con las orientaciones
    orientacion =[];

    % Obtengo para cada componenete el angulo entre el eje y el eje principal (entre 90 y -90)
    for i = 1:ncomp orientacion = [orientacion, regionprops(comp == i, 'Orientation')];end

    % Transformo la lista de estructuras en una lista de doubles
    orientacion=  cell2mat(struct2cell(orientacion));
    
    % Creo el historigrama con las orientaciones y lo guardo.
    histograma = histogram(orientacion, 45); 
    saveas(histograma, 'histograma.jpg');

    cd .. 
end 