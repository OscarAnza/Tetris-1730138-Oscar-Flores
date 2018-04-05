package{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class Main_Tetris extends MovieClip{
		//VARIABLES
		var select:int;
		var limite:int;
		var speed:int;
		//PIEZAS
		var pieza:DisplayObject;
		var piezas:Array = [];
		
		//Funcion Inicial
		public function Main_Tetris() {
			Pieza();
			
			stage.addEventListener(Event.ENTER_FRAME, Caida);
		}
		
		//GENERADOR DE PIEZAS
		private function Pieza(){
			//Generar un numero aleatorio
			select = Math.random() * 2 + 1;
			
			//En base al numero, generar la pieza correspondiente
			switch(select){
				case 1: pieza = new Pieza1(); 
						piezas.push(pieza);
						limite = 345; break;
				case 2: pieza = new Pieza2();
						piezas.push(pieza);
						limite = 375; break;
			}
			
			Colocar();
		}
		
		//Colocar la pieza en el escenario y hacer que caiga
		private function Colocar(){
			pieza.x = Math.random() * 400;
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