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