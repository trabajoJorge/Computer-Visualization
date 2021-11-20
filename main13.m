
function main(umbral)
      videoReader = VideoReader('V.mp4');
      videoPlayer = vision.VideoPlayer('Position',[100,100,680,520]);
      % Guardamos los frames en la variable Ip
      frameAnterior = readFrame(videoReader); 
      
      while hasFrame(videoReader)
            frameActual = readFrame(videoReader);
            %Diferenciamos la imagen previa y la posterior
            diferencia = abs(frameActual-frameAnterior) > umbral;
            % Filtramos la diferencia para ver si hay algun cambio notable
            frameAnterior = frameActual;
            videoPlayer(uint8(diferencia).*frameActual);
      end
      