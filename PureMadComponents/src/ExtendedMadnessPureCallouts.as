package
{
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import pureHelpers.UIFormMaker;
	import pureHelpers.UIListMaker;
	
	public class ExtendedMadnessPureCallouts extends Sprite {
		
		public function ExtendedMadnessPureCallouts(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var callout0:UICutCopyPaste = new UICutCopyPaste(this, 10.0, 50.0, -32, 0x666666, false, new <String>["This","Is","A","Callout"])
		
			var callout1:UIDropWindow = new UIDropWindow(this, <null/>, new Attributes(0, 0, 180, 300));
			callout1.x = 240.0;
			callout1.y = 50.0;
			
			var list:UIListMaker = new UIListMaker(callout1,
				0, 0, 180.0, 300.0,
				'background="#CCCCFF,#9999CC,#AAAACC" color="#FFFFFF" size="20" mask="true"'
			);
			list.data = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];


			var callout2:UIDropWindow = new UIDropWindow(this, <null/>, new Attributes(0, 0, 180, 135));
			callout2.x = 20.0;
			callout2.y = 150.0;
			
			var form:UIFormMaker = new UIFormMaker(callout2, 180, 135);
			form.attachVertical(new UIButton(form,0,0,"Option 1"));UIButton(form.lastChild()).fixwidth = 180;
			form.attachVertical(new UIButton(form,0,0,"Option 2"));UIButton(form.lastChild()).fixwidth = 180;
			form.attachVertical(new UIButton(form,0,0,"Option 3"));UIButton(form.lastChild()).fixwidth = 180;
			form.x=form.y=-UI.PADDING;
		}
	}
}