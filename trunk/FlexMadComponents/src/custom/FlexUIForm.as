/**
 * <p>Original Author: Daniel Freeman</p>
 *
 * <p>Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:</p>
 *
 * <p>The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.</p>
 *
 * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS' OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 */

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