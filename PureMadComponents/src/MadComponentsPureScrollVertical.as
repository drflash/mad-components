package
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import pureHelpers.UIScrollVerticalMaker;
	
	public class MadComponentsPureScrollVertical extends Sprite
	{
		public function MadComponentsPureScrollVertical(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var form:UIScrollVerticalMaker = new UIScrollVerticalMaker(this, 320, 434);
			form.attachVertical(new UIButton(form,0,0,"Hello"));
			form.attachVertical(new UIButton(form,0,0,"World"));
			form.attachVertical(new UISwitch(form,0,0));
			form.attachHorizontal(new UIInput(form,0,0,""));
			form.attach(new UISlider(form,10,150));
			for (var i:int = 0; i<10;i++)
				form.attachVertical(new UIButton(form,0,0,"button"));
		}
	}
}