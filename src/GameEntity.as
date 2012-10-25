package
{
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	// TODO: use centerX instead of using pixelwidth offsets?
	public class GameEntity extends Entity
	{
		[Embed(source = 'res/gameentity.png')] private const GAMEENTITY:Class;
		public var keyMap:Array;
		public var state:int; // 0 - none, 1 - pull , 2 = push
		public var playerNum:int;
		
		public var changedState:Boolean;
		public var lastDropX:int;
		public var lastDropY:int;
		
		public static var SPEED:int = 6;
		public static var PIXELWIDTH:int = 6;
		public static var PUSH:int = 1;
		public static var PULL:int = 2;
		
		// TODO: One color for 1p one color for 2p
		public function GameEntity(x:int = 0, y:int = 0, playerNumber:int = 1)
		{
			keyMap = new Array();
			super(x, y);
			graphic = new Image(GAMEENTITY);
			(graphic as Image).color = 0x49E20E;///0xFF0000 ;//red 
			(graphic as Image).tinting = 1;
			type = "gameentity";
			setHitbox(PIXELWIDTH, PIXELWIDTH);
			state = 0;
			playerNumber = playerNumber;
			changedState = false;
			lastDropX = 0;
			lastDropY = 0;
			
			if (playerNumber == 1) 
			{
				keyMap[0] = Key.A;
				keyMap[1] = Key.W;
				keyMap[2] = Key.D;
				keyMap[3] = Key.S;
				keyMap[4] = Key.Q;
				keyMap[5] = Key.E;
			}
			else 
			{
				keyMap[0] = Key.J;
				keyMap[1] = Key.I;
				keyMap[2] = Key.L;
				keyMap[3] = Key.K;	
				keyMap[4] = Key.U;
				keyMap[5] = Key.O;
			}
		}

		override public function update():void
		{
			changedState = false;
			
			// move the gameentity
			if (Input.check(keyMap[0])) { x -= SPEED; }
			if (Input.check(keyMap[1])) { y -= SPEED; }
			if (Input.check(keyMap[2])) { x += SPEED; }
			if (Input.check(keyMap[3])) { y += SPEED; }
			
			// keep in bounds
			if (x < 0) x = 0;
			if (x > FP.width - PIXELWIDTH) x = FP.width - PIXELWIDTH;
			if (y < 0) y = 0;
			if (y > FP.height - PIXELWIDTH) y = FP.height - PIXELWIDTH;
			
			// change pull state
			if (Input.check(keyMap[4])) { changedState = true; state = PUSH; lastDropX = x + GameDrop.PIXELWIDTH; lastDropY = y + GameDrop.PIXELWIDTH; }
			if (Input.check(keyMap[5])) { changedState = true; state = PULL; lastDropX = x + GameDrop.PIXELWIDTH; lastDropY = y + GameDrop.PIXELWIDTH; }
			
			// if count long enough and no collision
			if (!collide("gamedrop", x + GameDrop.PIXELWIDTH, y + GameDrop.PIXELWIDTH))
			{
				FP.world.add(new GameDrop(x + GameDrop.PIXELWIDTH,y + GameDrop.PIXELWIDTH,playerNum));
			}
		}
	}
}