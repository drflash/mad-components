package custom {
	
	import com.danielfreeman.madcomponents.Attributes;
	import com.danielfreeman.madcomponents.UIForm;
	
	import flash.display.Sprite;
	import spark.core.SpriteVisualElement;

	
	public class FlexUIForm extends SpriteVisualElement
	{
		protected var _component:Sprite;
		protected var _gap:Number = 0;
		protected var _xml:XML;
		protected var _attributes:Attributes;		
		
		public function FlexUIForm() {
		}
		
		
		override public function setLayoutBoundsSize(width:Number, height:Number, postLayoutTransform:Boolean=true):void {
			if ( isNaN( width ) )
				width = getPreferredBoundsWidth( postLayoutTransform );
			   
			if ( isNaN( height ) )
				height = getPreferredBoundsHeight( postLayoutTransform );
			
			if (!_component) {
				createComponent(width - 2*_gap, height - 2*_gap);
			}
			else {
				resizeComponent(width - 2*_gap, height - 2*_gap);
			}

			super.setLayoutBoundsSize(width, height, postLayoutTransform);
		}
		
		
		protected function createComponent(width:Number, height:Number):void {
			_attributes = new Attributes(0, 0, width, height);
			_attributes.parse(_xml);
			_component = new UIForm(this, _xml, _attributes);
			_component.x = _gap;
			_component.y = _gap;
		}
		
		
		protected function resizeComponent(width:Number, height:Number):void {
			_attributes.width = width;
			_attributes.height = height;
			UIForm(_component).layout(_attributes);
		}
		
		
		public function get component():Sprite {
			return _component;
		}
		
		
		public function set xml(value:XML):void {
			_xml = value;
		}
		
		
		override public function get height():Number {
			return _component ? _component.height + _gap : super.height;
		}
		
		
		override public function get width():Number {
			return _component ? _component.width + _gap : super.width;
		}

	}
}