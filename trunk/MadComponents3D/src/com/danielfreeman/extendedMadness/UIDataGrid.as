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

package com.danielfreeman.extendedMadness {

	import com.danielfreeman.madcomponents.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	
/**
 *  Datagrid component
 * <pre>
 * &lt;dataGrid
 *    id = "IDENTIFIER"
 *    colour = "#rrggbb"
 *    background = "#rrggbb, #rrggbb, ..."
 *    visible = "true|false"
 *    alignH = "left|right|centre|fill"
 *    alignV = "top|bottom|centre|fill"
 *    editable = "true|false"
 *    widths = "i(%),j(%),k(%)…"
 *    multiline = "true|false"
 *    titleBarColour = "#rrggbb"
 *    footerColour = "#rrggbb"
 *    <title>
 *    <font>
 *    <headerFont>
 *    <model>
 *    <widths> (depreciated)
 * /&gt;
 * </pre>
 */
	public class UIDataGrid extends Sprite implements IContainerUI { 
		
		protected static const DEFAULT_HEADER_COLOUR:uint=0x9999AA; //0x4481c1; 
		protected static const DEFAULT_COLOURS:Array=[0xe8edf5,0xcfd8e9]; 
		protected static const TABLE_WIDTH:Number=300.0;
		protected static const TEXT_SIZE:Number=12.0;
		protected static const HEADER_STYLE:TextFormat = new TextFormat('Arial', TEXT_SIZE, 0xFFFFFF);
		protected static const TITLE_STYLE:TextFormat = new TextFormat('Arial', 14, 0xFFFFFF, true);
		protected static const DATA_STYLE:TextFormat = new TextFormat('Arial', TEXT_SIZE, 0x333333);
		protected static const THRESHOLD:Number = 100.0;
		
		protected var _table:Array=new Array(); 
		protected var _last:Number=0; 
		protected var _lastWidth:Number; 
		protected var _cellWidths:Array = null; 
		protected var _leftMargin:Number;
		protected var _tableWidth:Number;
		protected var _data:Array = [];
		protected var _editable:Boolean = false;
		protected var _borderColour:uint;
		protected var _model:DGModel = null;
		protected var _colours:Array = DEFAULT_COLOURS;
		protected var _xml:XML;
		protected var _attributes:Attributes;
		
		protected var _compactTable:Boolean = false;
		protected var _columnWidths:Vector.<Number> = null;
		protected var _multiLine:Boolean = false;
		protected var _hasHeader:Boolean = false;
		protected var _dataStyle:TextFormat = DATA_STYLE;
		protected var _headerStyle:TextFormat = HEADER_STYLE;
		protected var _titleBarColour:uint = DEFAULT_HEADER_COLOUR;
		protected var _title:UIBlueText = null;
		protected var _footerColour:uint = uint.MAX_VALUE;
		
		
		public function UIDataGrid(screen:Sprite, xml:XML, attributes:Attributes) {							   

			screen.addChild(this); 
			x=attributes.x;
			y=attributes.y;
			_xml = xml;
			_attributes = attributes;
			
			_tableWidth=attributes.width;
			_leftMargin=4.0;
			
			_borderColour=attributes.colour;
			
			if (xml.widths.length() > 0) { // Depreciated
				_cellWidths = xml.widths.split(",");
			}
			if (xml.model.length() > 0) {
				_model = new DGModel(this,xml.model[0]);
			}
			if (xml.font.length() > 0) {
				_dataStyle = toTextFormat(xml.font[0]);
			}
			if (xml.headerFont.length() > 0) {
				_headerStyle = toTextFormat(xml.headerFont[0]);
			}
			if (xml.@footerColour.length() > 0) {
				_footerColour = UI.toColourValue(xml.@footerColour);
			}

			customWidths();
			_compactTable = xml.@widths.length() == 0;		
			_editable = xml.@editable[0] == "true";
			if (xml.@multiLine.length() > 0) {
				_multiLine = xml.@multiLine == "true";
			}
			
			var headerText:Array = extractHeader(xml);
			var headerColour:uint = (attributes.backgroundColours.length>0) ? attributes.backgroundColours[0] : DEFAULT_HEADER_COLOUR;
			_titleBarColour = headerColour;
			if (xml.@titleBarColour.length() > 0) {
				_titleBarColour = UI.toColourValue(xml.@titleBarColour);
			}
			if (xml.title.length() > 0) {
				_title = new UIBlueText(this, 0, 0, "", attributes.width, TITLE_STYLE);
				_title.selectable = _title.mouseEnabled = false;
				_last = _title.height;
				title = xml.title.toString();
				_title.fixwidth = attributes.width;
				_title.defaultColour = _titleBarColour;
			}

			if (headerText) {
				_hasHeader = true;
				makeTable([headerText], [headerColour], _headerStyle);
			}
			
			if (attributes.backgroundColours.length>1) {
				_colours = [];
				for (var i:int = 1; i < attributes.backgroundColours.length; i++) {
					_colours.push(attributes.backgroundColours[i]);
				}
			}
			
			if (xml.data.length()>0) {
				extractData(xml.data[0]);
			}

			makeTable(_data, _colours, null, _editable);
			colourFooter(_footerColour);
			layout(attributes);
		}
		
		
		public function set title(value:String):void {
			if (XML("<a>"+value+"</a>").hasComplexContent()) {
				_title.htmlText = value;
			}
			else {
				_title.text = value;
				_title.setTextFormat(TITLE_STYLE);
			}
		}
		
		
		public function get titleCell():UIBlueText {
			return _title;
		}
		
		
		protected function toTextFormat(formatXML:XML):TextFormat {
			var textField:TextField = new TextField();
			var fontString:String = formatXML.toXMLString();
			fontString = fontString.substring(fontString.indexOf(" "), fontString.length - 2);
			textField.htmlText = "<font" + fontString + "> </font>";
			return textField.getTextFormat();
		}
		
		
		protected function customWidths():void {
			if (_xml.@widths.length() > 0 && _table.length > 0) {
				var total:Number = 0;
				var widths:Array = _xml.@widths.toString().split(",");
				for each (var item : String in widths) {
					if (item.lastIndexOf("%") < 0) {
						total += parseInt(item);
					}
				}
				_columnWidths = new Vector.<Number>();
				for each (var width:String in widths) {
					_columnWidths.push((width.lastIndexOf("%") > 0) ? parseFloat(width)/100 * (_attributes.width - total) : parseFloat(width));			
				}		
			}
			rejig();
		}
		
		
		protected function colourFooter(footerColour:uint):void {
			if (footerColour < uint.MAX_VALUE && _table.length > (_hasHeader ? 1 : 0)) {
				var lastRow:Array = _table[_table.length - 1];
				for each (var cell:UIBlueText in lastRow) {
					cell.defaultColour = footerColour;
				}
			}
		}
		
		
		protected function makeTable(data:Array,colours:Array, format:TextFormat=null, editable:Boolean=false):void {  
			if (!format) format=_dataStyle;
			format.leftMargin=_leftMargin; 
			for (var i:int=0;i<data.length;i++) { 
				var dataRow:Array=data[i]; 
				var row:Array=_table[_table.length]=new Array(); 
				var wdth0:Number=_tableWidth/dataRow.length; 
				var lastX:Number=0; 
				for (var j:int=0;j<dataRow.length;j++) { 
					var wdth:Number=(_cellWidths) ? _tableWidth*_cellWidths[Math.min(_cellWidths.length-1,j)]/100 : wdth0;
					var txt:UIBlueText = new UIBlueText(this, lastX, _last, dataRow[j], wdth, format);
					row.push(txt); 
					txt.fixwidth = wdth;
					txt.border = true;
					txt.borderColor = _borderColour;
					txt.multiline = txt.wordWrap = _multiLine;
					txt.setTextFormat(format);
					lastX=txt.x+txt.width;
					
					if (colours!=null) {
						txt.defaultColour = colours[i%colours.length];
					}
						
					txt.mouseEnabled=editable; 
				} 
				if (txt) {
					_last=txt.y+txt.height; 
				}
			} 
		}
		
		
		public function get pages():Array {
			return [];
		}
		
		
		protected function extractData(xml:XML):void {
			var rows:XMLList = xml.row;
			_data=new Array();
			for each (var row:XML in rows) {
				var dataRow:Array = row.toString().split(",");
				_data.push(dataRow);
			}
		}
		
		
		protected function rejig():void {
			var lastY:Number = 0;
			if (_title) {
				_title.fixwidth = _tableWidth;
				lastY = _title.height;
			}
			for (var i:int = 0; i<_table.length;i++) {
				var row:Array = _table[i];
				var wdth0:Number=_tableWidth/row.length;
				var position:Number = 0;
				var maxHeight:Number = 0;
				for (var j:int = 0; j < row.length; j++) {
					var wdth:Number= Math.round(_columnWidths ? _columnWidths[j] : (_cellWidths) ? _tableWidth*_cellWidths[Math.min(_cellWidths.length-1,j)]/100 : wdth0);
					var cell:UIBlueText = UIBlueText(row[j]);
					cell.x = position;
					cell.fixwidth = wdth;
					cell.multiline = cell.wordWrap = _multiLine;
					position += wdth;
					if (_multiLine) {
						cell.autoSize = TextFieldAutoSize.LEFT;
						if (cell.height > maxHeight) {
							maxHeight = cell.height;
						}
					}
				}
				if (_multiLine) {
					for each (var cell0:UIBlueText in row) {
						cell0.fixheight = maxHeight;
						cell0.y = lastY;
					}
					lastY += maxHeight;
				}
			}
		}
		
		
		public function layout(attributes:Attributes):void {
			x=attributes.x;
			y=attributes.y;
			_attributes = attributes;
			_tableWidth=attributes.width;
			if (_cellWidths) {
				rejig();
			}
			else if (_xml.@widths.length()>0) {
				customWidths();
			}
			else if (_compactTable) {
				compact(true);
			}
			else {
				rejig();
			}
		}
		
		
		public function drawComponent():void {	
		}
		
/**
 * Clear the data grid
 */
		public function clear():void {
			for (var i:int = (_hasHeader ? 1 : 0); i<_table.length;i++) {
				var row:Array = _table[i];
				for (var j:int=0;j<row.length;j++) {
					var cell:UIBlueText = row[j];
					UIBlueText(cell).destructor();
					cell.parent.removeChild(cell);
				}
			}
			_table = _hasHeader ? [_table[0]] : [];
		}
		
/**
 * Find a particular row,column (group) inside the grid
 */
		public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			return (id=="") ? _table[row][group] : null;
		}
		
		
		protected function extractHeader(xml:XML):Array {
			if (xml.header.length()>0) {
				return xml.header[0].toString().split(",");
			}
		//	else if (xml.data.length()>0 && xml.data[0].header.length()>0) {
		//		return xml.data[0].header[0].toString().split(",");
		//	}
			else {
				return null;
			}
		}
		
		
		public function colourRow(row:int, colour:uint, colourHeaders:Boolean = false):void {
			if (colourHeaders || !_hasHeader || row > 0) {
				var tableRow:Array = _table[row];
				for each (var cell:UIBlueText in tableRow) {
					cell.defaultColour = colour;
				}
			}
		}
		
		
		public function restoreRow(row:int, colourHeaders:Boolean = false):void {
			if (colourHeaders || !_hasHeader || row > 0) {
				var tableRow:Array = _table[row];
				for each (var cell:UIBlueText in tableRow) {
					cell.defaultColour = _colours[(row - (_hasHeader ? 1.0 : 1.0)) % _colours.length];
				}
			}
		}
		
		
		public function yToRow(y:Number):int {
			var result:int = -1;
			if (_table.length > 0) {
				while (result + 1 < _table.length && y > _table[result + 1][0].y) {
					result++;
				}
			}
			return result;
		}
		
/**
 * Set datagrid data
 */
		public function set data(value:Array):void {
			clear();
			_data = value;
			makeTable(_data, _colours, null, _editable);
			colourFooter(_footerColour);
		}
		
/**
 * Refresh datagrid with new data
 */
		public function set dataProvider(value:Array):void {
			_data = value;
			invalidate();
		}
		
/**
 * Refresh datagrid
 */
		public function invalidate(readGrid:Boolean = false):void {
			var start:int = _hasHeader ? 1 : 0;
			for (var i:int = start; i<_table.length; i++) {
				var row:Array = _table[i];
				for (var j:int=0; j<row.length; j++) {
					if (readGrid) {
						_data[i-start][j] = row[j].text;
					}
					else {
						row[j].text = _data[i-start][j];
					}
				}
			}
		}
		
		
		public function get xml():XML {
			return _xml;
		}
		
		
		public function get attributes():Attributes {
			return _attributes;
		}
		
		
		public function get tableCells():Array {
			return _table;
		}
		

		public function get hasHeader():Boolean {
			return _hasHeader;
		}
		
		
		public function compact(padding:Boolean = false):void {
			if (_table.length > 0) {
				_columnWidths = new Vector.<Number>(_table[0].length);
				for (var i:int = 0; i<_table.length; i++) {
					var row:Array = _table[i];
					for (var j:int=0; j<row.length; j++) {
						var cell:UIBlueText = UIBlueText(row[j]);
						cell.multiline = cell.wordWrap = false;
						cell.autoSize = TextFieldAutoSize.LEFT;
						if (cell.width > _columnWidths[j]) {
							_columnWidths[j] = cell.width;
						}
					}
				}
				if (padding) {
					var sum:Number = 0;
					for each (var width:Number in _columnWidths) {
						sum += width;
					}
					if (sum < _tableWidth) {
						var padEachCellBy:Number = (_tableWidth - sum) / _columnWidths.length;
						for (var k:int = 0; k < _columnWidths.length; k++) {
							_columnWidths[k] += padEachCellBy;
						}
					}
					else if (_multiLine) {
						var maxColumn:int = -1;
						var maxValue:Number = 0;
						for (var l:int = 0; l < _columnWidths.length; l++) {
							if (_columnWidths[l] > maxValue) {
								maxColumn = l;
								maxValue = _columnWidths[l];
							}
						}
						if (sum - _tableWidth + THRESHOLD < _columnWidths[maxColumn]) {
							_columnWidths[maxColumn] -= sum - _tableWidth;
						}
					}
				}
				rejig();
			}
		}
		
		
		override public function get height():Number {
			return getBounds(this).bottom;
		}
		
		
		public function destructor():void {
			for (var i:int = 0; i<_table.length;i++) {
				var row:Array = _table[i];
				for (var j:int=0;j<row.length;j++) {
					UIBlueText(row[j]).destructor();
				}
			}
		}
		
	} 
}
