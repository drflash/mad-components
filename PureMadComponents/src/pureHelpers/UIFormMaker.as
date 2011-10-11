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

package pureHelpers
{
	import com.danielfreeman.madcomponents.Attributes;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UI;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class UIFormMaker extends UIForm
	{
		protected static const GAP:Number = 8.0;
		
		protected var _pureLayer:Sprite;
		protected var _gap:Number = GAP;
		
		public function UIFormMaker(screen:Sprite, width:Number, height:Number, style:String = "") {
			super(screen,XML("<null "+style+"/>"), new Attributes(0, 0, width, height));
			addChild(_pureLayer = new Sprite());
		}
		
		
		public function set gap(value:Number):void {
			_gap = value;
		}
		
		
		public function attach(child:DisplayObject):void {
			_pureLayer.addChild(child);
		}
		
		
		public function attachHorizontal(child:DisplayObject):void {
			var lastChild:DisplayObject = _pureLayer.numChildren>0 ? _pureLayer.getChildAt(_pureLayer.numChildren - 1) : null;
			_pureLayer.addChild(child);
			child.x = lastChild ? lastChild.x + lastChild.width + _gap : UI.PADDING;
			child.y = lastChild ? lastChild.y : UI.PADDING;
		}
		
		
		public function attachVertical(child:DisplayObject):void {
			var lastChild:DisplayObject = _pureLayer.numChildren>0 ? _pureLayer.getChildAt(_pureLayer.numChildren - 1) : null;
			_pureLayer.addChild(child);
			child.x = lastChild ? lastChild.x : UI.PADDING;
			child.y = lastChild ? lastChild.y + lastChild.height + _gap : UI.PADDING;
		}
	}
}