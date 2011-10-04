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
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 */


package renderer
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class CustomRenderer extends MadSprite implements IContainerUI {
		
		protected static const HEIGHT:Number = 32.0;
		
		protected var _attributes:Attributes;
		protected var _xml:XML;
		
		protected var _label:UILabel;
		protected var _arrow:UIArrow;
		
		public function CustomRenderer(screen:Sprite, xml:XML, attributes:Attributes) {
			screen.addChild(this);
			
			_label = new UILabel(this, 0, 0);
			_arrow = new UIArrow(this, 0, 0, 0x334433, new <uint>[0xCCCCBB,0x999988]);
			_arrow.clickable = true;
			layout(attributes);
			mouseEnabled = false;
		}
		
		
		public function clear():void {
		}
		
		
		public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			if (id=="label")
				return _label;
			else
				return null;
		}
		
		
		public function layout(attributes:Attributes):void {
			_label.y = (HEIGHT - _label.height ) / 2 ;//+ attributes.paddingH;
			_arrow.y = (HEIGHT - _arrow.height ) / 2 ;//+ attributes.paddingH;
			_arrow.x = attributes.width - _arrow.width;
			graphics.clear();
			graphics.beginFill(0,0);
			graphics.drawRect(0, 0, attributes.width, height);
		}
		
		
		public function get pages():Array {
			return [this];
		}
		
		
		public function get attributes():Attributes {
			return _attributes;
		}
		
		
		public function get xml():XML {
			return _xml;
		}
		
		
		public function destructor():void {
		}
	}
}