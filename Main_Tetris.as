package{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Main_Tetris extends MovieClip{
		//VARIABLES
		var select:int;
		var limite:int;
		var speed:int;
		//PIEZAS
		var creadorS:Sprite = new Sprite();
		var atomo1:Atomo1;
		var cuadro:Cuadro;
		var generador:Array = [];
		var posX:Number;
		var posY:Number;
		
		var pieza:DisplayObject;
		var piezas:Array = [];
		
		//Funcion Inicial
		public function Main_Tetris() {
			creadorS.x = creador.x;
			creadorS.y = creador.y;
			addChild(creadorS);
			
			Pieza();
			
			piece.addEventListener(MouseEvent.CLICK, Cambiar);
			//stage.addEventListener(Event.ENTER_FRAME, Caida);
		}
		
		//FUNCION TEMPORAL
		private function Cambiar(event:MouseEvent){
			Pieza();
		}
		
		//GENERADOR DE PIEZAS
		private function Pieza(){
			//Generar un numero aleatorio
			select = Math.random() * 7 + 1;
			posX = 0;
			posY = 0;
			
			//En base al numero, generar la pieza correspondiente
			switch(select){
				case 1: generador = [[0,0,0,0],
									 [0,1,0,0],
									 [0,1,0,0],
									 [0,1,1,0]]
						limite = 445; break;
						
				case 2: generador = [[0,0,0,0],
									 [0,0,1,0],
									 [0,0,1,0],
									 [0,1,1,0]]
						limite = 475; break;
						
				case 3: generador = [[0,0,0,0],
									 [0,1,1,0],
									 [0,1,1,0],
									 [0,0,0,0]]
						limite = 475; break;
						
				case 4: generador = [[0,0,0,0],
									 [0,0,1,0],
									 [0,1,1,0],
									 [0,1,0,0]]
						limite = 475; break;
						
				case 5: generador = [[0,0,0,0],
									 [0,1,0,0],
									 [0,1,1,0],
									 [0,0,1,0]]
						limite = 475; break;
						
				case 6: generador = [[0,1,0,0],
									 [0,1,0,0],
									 [0,1,0,0],
									 [0,1,0,0]]
						limite = 475; break;
						
				case 7: generador = [[0,0,0,0],
									 [0,1,0,0],
									 [0,1,1,0],
									 [0,1,0,0]]
						limite = 475; break;
			}
			
			Generar();
			//Colocar();
		}
		
		private function Generar(){
			
			for(var a:int = 0; a < 4; a++){
				for(var b:int = 0; b < 4; b++){
					trace("posX: " + posX);
					cuadro = new Cuadro;
					atomo1 = new Atomo1;
					if(generador[a][b] == 0){
						
						cuadro.x = (posX * 20);
						cuadro.y = (posY * 20);
						creadorS.addChild(cuadro);
					}
					else{
						
						atomo1.x = (posX * 20);
						atomo1.y = (posY * 20);
						creadorS.addChild(atomo1);
					}
					trace("a: " + a + ", " + "b: " + b);
					posX++;
				}
				trace("posY: " + posY);
				posX = 0;
				posY++;
			}
		}
		
		//Colocar la pieza en el escenario y hacer que caiga
		private function Colocar(){
			pieza.x = Math.random() * 400 + 20;
			pieza.y = -10;
			addChild(pieza);
			
			//Establecer velocidad de caida
			speed = 5;
		}
		
		//CAIDA DE LAS PIEZAS
		private function Caida(event:Event){
			pieza.y += speed;
			
			//Condicion para detener las piezas
			if(pieza.y > limite){
				speed = 0;
				Pieza();
			}
		}
		
		//GENERADOR DE FISICA DEL JUEGO
		private function Fisica(event:Event){
			for(var a:int = 0; a < piezas.length; a++){
				//Longitudes de las piezas
				var r1x = piezas[a].width / 2;
				var r1y = piezas[a].height / 2;
				var r2x = piezas[a + 1].width / 2;
				var r2y = piezas[a + 1].height / 2;
				
				var r1xs = r1x + r2x;
				var r1ys = r1y + r2y;
				
				//Coordenadas de los centros
				var a1x = piezas[a] + r1x;
				var a1y = piezas[a] + r1y;
				var a2x = piezas[a+1] + r2x;
				var a2y = piezas[a+1] + r2y;
				
				//Distancia entre los centros
				var d1 = Math.sqrt(((r2x - r1x) * (r2x - r1x)) + ((r2y - r1y) * (r2y - r1y)));
				
				if(d1 < r1xs || d1 < r1ys){
					speed = 0;
					Pieza();
				}
			}
		}
	}
}