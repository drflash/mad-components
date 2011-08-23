package custom {
	
	import com.danielfreeman.madcomponents.UISlider;
	
	public class FlexUISlider extends FlexUIForm {

		public function FlexUISlider() {
		}
		
		
		override protected function createComponent(width:Number, height:Number):void {
			_component = new UISlider(this, 0, 0, new <uint>[]);
			UISlider(_component).fixwidth = width;
		}
		
		
		override protected function resizeComponent(width:Number, height:Number):void {
			UISlider(_component).fixwidth = width;
		}
	}
}