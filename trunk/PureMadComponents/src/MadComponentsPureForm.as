package
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import pureHelpers.UIFormMaker;
	
	public class MadComponentsPureForm extends Sprite
	{
		public function MadComponentsPureForm(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var form:UIFormMaker = new UIFormMaker(this, 320, 434,'background="#CCCCCC"');
			form.attachVertical(new UIButton(form,0,0,"Hello"));
			form.attachVertical(new UIButton(form,0,0,"World"));
			form.attachVertical(new UISwitch(form,0,0));
			form.attachHorizontal(new UIInput(form,0,0,""));
			form.attach(new UISlider(form,10,150));
		}
	}
}