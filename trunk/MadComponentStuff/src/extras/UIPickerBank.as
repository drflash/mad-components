package extras
{
	import com.danielfreeman.madcomponents.Attributes;
	import com.danielfreeman.madcomponents.UIForm;
	
	import flash.display.Sprite;

	public class UIPickerBank extends UIForm
	{
		protected static const HEIGHT:Number = 160.0;
		protected static const GAP:Number = 10.0;
		
		public function UIPickerBank(screen:Sprite, xx:Number, yy:Number, width:Number, height:Number = 200.0, columns:uint = 1, widths:String = "")
		{
			super(screen, createComponent(width, height, columns, widths), new Attributes(0, GAP, width, height));
			x = xx;
			y = yy;
		}
		 
		
		protected function createComponent(width:Number, height:Number, columns:uint, widths:String):XML {
			if (height<HEIGHT)
				height = HEIGHT;
			var xml:String = '<columns gapH="0" width="'+width.toString()+'" height="'+height.toString()+'" pickerHeight="' + height.toString() + '"';
			if (widths!="") {
				xml += ' widths="' + widths + '"';
			}
			xml += '>';
			var index:int = 0;
			for(var i:int = 0; i<columns; i++) {
				xml += '<picker id="column'+i.toString()+'"/>';
			}
			return XML(xml + '</columns>');
		}
	}
}