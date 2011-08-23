package custom {
	
	import com.danielfreeman.madcomponents.UISwitch;
	
	public class FlexUISwitch extends FlexUIForm {

		public function FlexUISwitch() {
		}
		
		
		override protected function createComponent(width:Number, height:Number):void {
			_component = new UISwitch(this, 0, 0);
		}
		
		
		override protected function resizeComponent(width:Number, height:Number):void {
		}
	}
}