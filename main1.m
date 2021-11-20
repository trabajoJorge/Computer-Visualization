% Resolucion basada en la solucion presentada en la de Aitor Iglesias
function main()
    % Creo la carpeta de resultados y de existir la elimino
    if not(exist('Solución', 'dir'))
        mkdir Solución
    else
        cd 'Solución'
        delete *
        cd ..
    end
    %  Cargo, todas las imagenes, las mascaras y las imagenes
    %  Nombres de las imagenes de las mascaras

    mascaras = ["image-1-moon-mask.jpg", "image-1-rock-mask.jpg", "image-2-brotes-mask.jpg", "image-3-dragon-mask.jpg", "image-3-fondo-mask.jpg", "image-3-letras-mask.jpg", "image-3-rueda-mask.jpg"];
    NombreCompletoImagenes = ["image-1-moon.jpg", "image-1-rock.jpg", "image-2-brotes.jpg", "image-3-dragon.jpg", "image-3-fondo.jpg", "image-3-letras.jpg", "image-3-rueda.jpg"];
    ID = ["moon", "rock", "brotes", "dragon", "fondo", "letras", "rueda"];
    
    
    clave = {'moon1Min', 'moon1Max', 'moon2Min', 'moon2Max', 'moon3Min', 'moon3Max',
           'rock1Min', 'rock1Max', 'rock2Min', 'rock2Max', 'rock3Min', 'rock3Max',
           'brotes1Min', 'brotes1Max', 'brotes2Min', 'brotes2Max', 'brotes3Min', 'brotes3Max',
           'dragon1Min', 'dragon1Max', 'dragon2Min', 'dragon2Max', 'dragon3Min', 'dragon3Max',
           'fondo1Min', 'fondo1Max', 'fondo2Min', 'fondo2Max', 'fondo3Min', 'fondo3Max',
           'letras1Min', 'letras1Max', 'letras2Min', 'letras2Max', 'letras3Min', 'letras3Max',
           'rueda1Min', 'rueda1Max', 'rueda2Min', 'rueda2Max', 'rueda3Min', 'rueda3Max'};

    % Se alojan en una matriz los valores RGB obtenidos mediante la herramienta color Thresholder
    valores = [ 150.000,    255.000,    175.000,    255.000,    150.000,    255.000,
                115.000,    255.000,    50.000,     110.000,    0.000,      50.000,
                0.000,      255.00,     173.000,    255.000,    2.000,      145.000,
                119.000,    255.000,    0.000,      53.000,     0.000,      52.000,
                120.000,    155.000,    120.000,    175.000,    102.000,    152.000,
                14.000,     131.000,    0.000,      67.000,     0.000,      51.000,
                151.000,    202.000,    72.000,     136.000,    54.00,      114.000];
    
    % Se crea una tabla hash para tener un acceso mas sencillo a posteriori. Esta tabla recoge la clave y los valores de las mascaras
    hash = containers.Map(clave,valores);

    % Se hace la lectura de imagenes ajustandose a los parametros establecidos en el enunciado
    for i = 1:7
        if i == 1 
            image_RGB = imread('image-1.jpg');
            dim = numel(image_RGB);
        elseif i == 3
            image_RGB = imread('image-2.jpg');
            dim = numel(image_RGB);
        elseif i == 4
            image_RGB = imread('image-3.jpg');
            dim = numel(image_RGB);
        end

        
        % Se genera la mascara y la nueva imagen
        [BW, new_RGB] = createMask(image_RGB, hash(strcat(ID(i),'1Min')), hash(strcat(ID(i),'1Max')), hash(strcat(ID(i),'2Min')), hash(strcat(ID(i),'2Max')), hash(strcat(ID(i),'3Min')), hash(strcat(ID(i),'3Max')));

        % Guardo la imagen sin la mascara para despues compararla con la imagen obtenida 
        BW_0 = imread(mascaras(i));
        BW_0 = logical(BW_0);

        % Guardo los resultados obtenidos en la carpeta Solución
        cd 'Solución'
        imwrite(BW, mascaras(i));
        imwrite(new_RGB, NombreCompletoImagenes(i))
        cd ..

        % Imprimo por consola la diferencia de las imagenes
        diferencia = sum(sum(abs(BW_0 - BW)))/(dim);
        fprintf("La diferencia entre %s y %s es %d\n", NombreCompletoImagenes(i), mascaras(i), diferencia);   

    end

end

% Funcion generada con Color Thresholder, que genera una mascara dandole los siguientes datos
function [BW,new_RGB] = createMask(RGB, channel1Min, channel1Max, channel2Min, channel2Max, channel3Min, channel3Max)
    I = RGB;
    sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
        (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
        (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
    BW = sliderBW;
    new_RGB = RGB;
    new_RGB(repmat(~BW,[1 1 3])) = 0;
end
