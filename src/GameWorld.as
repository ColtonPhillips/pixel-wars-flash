package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	public class GameWorld extends World
	{
		public static var player1:GameEntity;
		public static var player2:GameEntity;
		
		public function GameWorld()
		{	
			GameWorld.player1 = new GameEntity(GameEntity.PIXELWIDTH, GameEntity.PIXELWIDTH, 1);
			add(player1);
			
			GameWorld.player2 = new GameEntity(FP.width - GameEntity.PIXELWIDTH*2, FP.height - GameEntity.PIXELWIDTH*2, 2);
			add(player2);
		}
		
		public override function update():void
		{
			super.update();
			
			//var dropList:Array = [];
			
			//getType("gamedrop", dropList);
			//dropList.sortOn("x");
			//for each (var d:GameDrop in dropList) {
				//trace(d.x);
				
			//}
			//while (true) {}
		}
	}
}