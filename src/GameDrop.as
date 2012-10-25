package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	public class GameDrop extends Entity
	{
		[Embed(source = 'res/gamedrop.png')] private const GAMEDROP:Class;
		
		public var xspeed:Number;
		public var yspeed:Number;
		
		public static var PUSHPULLSPEED:Number = 2;
		public static var PIXELWIDTH:Number = 2;
		
		public function GameDrop(x:int = 0, y:int = 0, playerNum:int = 1 )
		{
			super(x, y);
			graphic = new Image(GAMEDROP);
			(graphic as Image).color = 0xFFAABC;
			
			(graphic as Image).tinting = 1;
			// todo: diff type per player drop?
			type = "gamedrop";
			setHitbox(2, 2);
			playerNum = playerNum;
			xspeed = 0;
			yspeed = 0;
		}

		override public function update():void
		{
			// keep in bounds - reverse speed
			if (x < 0) { x = 0 ; xspeed = -1 * xspeed; }
			if (x > FP.width - 2) { x = FP.width - 2 ;xspeed = -1 * xspeed;}
			if (y < 0) { y = 0 ;yspeed = -1 * yspeed;}
			if (y > FP.height - 2) { y = FP.height - 2 ;yspeed = -1 * yspeed;}
			
			//if (collide("gamedrop", x, y)) { }
			
			if (GameWorld.player1.changedState)
			{
					
				if (GameWorld.player1.state == GameEntity.PUSH) 
				{
					// move away
					FP.point.x = x - GameWorld.player1.lastDropX;
					FP.point.y = y - GameWorld.player1.lastDropY;
					FP.point.normalize(PUSHPULLSPEED);
					
					xspeed = FP.point.x;
					yspeed = FP.point.y;
					
				}
				if (GameWorld.player1.state == GameEntity.PULL) 
				{
					// move towards
					FP.point.x = GameWorld.player1.lastDropX - x;
					FP.point.y = GameWorld.player1.lastDropY - y;
					FP.point.normalize(PUSHPULLSPEED);
					
					xspeed = FP.point.x;
					yspeed = FP.point.y;
				}
				
			
			}
			
			x += xspeed;
			y += yspeed;
		}
	}
}