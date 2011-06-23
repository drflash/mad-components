package
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	
	public class MadImage extends Sprite
	{
		[Embed(source="images/mp3_48.png")]
		protected static const MP3:Class;
		
		[Embed(source="images/mp4_48.png")]
		protected static const MP4:Class;
		
		protected static const IMAGE:XML = <image id="myImage" alignH="centre" alignV="centre">
			{getQualifiedClassName(MP3)}
		</image>;
		
		protected var _myImage:UIImage;
		protected var _toggle:Boolean = true;
		
		public function MadImage(screen:Sprite = null)
		{
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, IMAGE);
			
			_myImage = UIImage(UI.findViewById("myImage"));
			_myImage.addEventListener(MouseEvent.MOUSE_UP,clicked);
			_myImage.mouseEnabled = true;
		}
		
		
		protected function clicked(event:MouseEvent):void {
			_toggle = !_toggle;
			_myImage.imageClass = _toggle ? MP3 : MP4;
		}
	}
}