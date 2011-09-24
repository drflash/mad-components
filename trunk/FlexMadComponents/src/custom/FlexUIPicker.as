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
	
	public class FlexUIPicker extends FlexUIForm {
		
		protected static const HEIGHT:Number = 160.0;

		protected var _columns:int = 1;
		protected var _data:Array = null;
		protected var _xmlData:XML = null;
		protected var _widths:String = "";
		protected var _pickerHeight:String = "";


		public function FlexUIPicker() {
			_gap = 10;
		}
		
		
		public function set columns(value:int):void {
			_columns = value;
		}
		
		
		public function set widths(value:String):void {
			_widths = value;
		}
		
		
		public function set pickerHeight(value:String):void {
			_pickerHeight = value;
		}
		
		
		public function set data(value:Array):void {
			if (_component) {
				var pickerIndex:int = 0;
				for each (var columnData :Array in value) {
					UIForm(_component).pages[pickerIndex++] = columnData;
				}
			}
			else {
				_data = value;
				_xmlData = null;
			}
		}
		
		
		public function set xmlData(value:XML):void {
			if (_component) {
				var pickerIndex:int = 0;
				for each (var columnData :XMLList in value) {
					UIForm(_component).pages[pickerIndex++] = columnData[0];
				}
			}
			else {
				_xmlData = value;
				_data = null;
			}		
		}
		
		
		override protected function createComponent(width:Number, height:Number):void {
			if (height<HEIGHT)
				height = HEIGHT;
			var xml:String = '<columns gapH="0" width="'+width.toString()+'" height="'+height.toString()+'" pickerHeight="' + height.toString() + '"';
			if (_widths!="") {
				xml += ' widths="' + _widths + '"';
			}
			xml += '>';
			var index:int = 0;
			for(var i:int = 0; i<_columns; i++) {
				xml += '<picker id="column'+i.toString()+'">' + theData(index++) + '</picker>';
			}
			_xml = XML(xml + '</columns>');
			super.createComponent(width, height);
		}
			
			
		protected function theData(value:int):String {
			if (_data) {
				var result:String = '<data>';
				for each (var item:String in _data[value]) {
					result+='<item label="'+item+'"/>';
				}
				return result+'</data>';
			}
			else if (_xmlData) {
				var group:String = _xmlData.group[value].toString();
				return "<data"+group.substring(group.indexOf(">"),group.lastIndexOf("<"))+"</data>";
			}
			else {
				return "";
			}
		}

	}
}