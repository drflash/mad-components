package
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getQualifiedClassName;
	
	
	public class MadComponentsScrollXY extends Sprite
	{
		[Embed(source="images/thailand.png")]
		protected static const THAILAND:Class;
		
		protected static const SCROLLXY:XML = <scrollXY stageColour="#666666" scrollBarColour="#FFFFFF" width="480" height="640" border="false" id="scroller">
				<image>
					{getQualifiedClassName(THAILAND)}
				</image>
			</scrollXY>;
		
		public function MadComponentsScrollXY(screen:Sprite = null)
		{
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, SCROLLXY);
			
			var scroller:UIScrollXY = UIScrollXY(UI.findViewById("scroller"));
			scroller.scale = 1.2;
		}
	}
}