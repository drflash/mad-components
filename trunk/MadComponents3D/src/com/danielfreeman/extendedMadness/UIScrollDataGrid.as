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
	
	import com.danielfreeman.extendedMadness.UIDataGrid;

	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import com.danielfreeman.madcomponents.*;
	import flash.events.MouseEvent;
	import flash.events.Event;

/**
 * ScrollDatagrid component
 * <pre>
 * &lt;dataGrid
 *    id = "IDENTIFIER"
 *    colour = "#rrggbb"
 *    background = "#rrggbb, #rrggbb, ..."
 *    visible = "true|false"
 *    widths = "p,q,r..."
 *    alignH = "left|right|centre|fill"
 *    alignV = "top|bottom|centre|fill"
 *    editable = "true|false"
 *    widths = "i(%),j(%),k(%)…"
 *    multiline = "true|false"
 *    titleBarColour = "#rrggbb"
 *    gapV = "NUMBER"
 *    gapH = "NUMBER"
 *    border = "true|false"
 *    autoLayout = "true|false"
 *    tapToScale = "NUMBER"
 *    auto = "true|false"
 *    fixedColumns = "n"
 *    fixedColumnsColours = "#rrggbb, #rrggbb, ..."
 *    <title>
 *    <font>
 *    <headerFont>
 *    <model>
 *    <widths> (depreciated)
 * /&gt;
 * </pre>
 */
	public class UIScrollDataGrid extends UIScrollXY {
		
		
		public static const SWIPE_RIGHT:String = "swipeRight";
		public static const SWIPE_LEFT:String = "swipeLeft";
		
		protected var _headerSlider:Sprite;
		protected var _fixedColumnSlider:Sprite = null;
		protected var _headerFixedColumnSlider:Sprite = null;
		protected var _dataGridXML:XML;
		protected var _fixedColumns:int = 0;
		protected var _fixedColumnColours:Vector.<uint> = null;
		protected var _dataGrid:UIDataGrid;
		protected var _trigger:Boolean = true;

		
		public function UIScrollDataGrid(screen : Sprite, xml : XML, attributes : Attributes) {
			_dataGridXML = xml;
			if (xml.@fixedColumnColours.length() > 0) {
				_fixedColumnColours = UI.toColourVector(xml.@fixedColumnColours);
			}
			super(screen, noChildren(xml), attributes);
		}


		protected function noChildren(xml:XML):XML {
			var result:String = xml.toXMLString();
			var position:int = result.indexOf(">");
			if (result.substr(position - 1, 1) == "/") {
				result = result.substring(0, position + 1);
			}
			else {
				result = result.substring(0, position) + "/>";
			}
			return XML(result);
		}
		
		
		protected function sliceTable(dataGrid:UIDataGrid):void {
			if (dataGrid.hasHeader && !_headerSlider) {
				addChild(_headerSlider = new Sprite());
			}
			if (xml.@fixedColumns.length() > 0 && !_fixedColumnSlider) {
				_fixedColumns = parseInt(xml.@fixedColumns);
				addChild(_fixedColumnSlider = new Sprite());
				addChild(_headerFixedColumnSlider = new Sprite());
			}
			if (_fixedColumns > 0 && dataGrid.tableCells.length > 0) {
				
				var rowIndex:int = 0;
				var start:int = dataGrid.hasHeader  ? 1 : 0;
				for (var i:int = 0; i < dataGrid.tableCells.length; i++) {
					var tableRow:Array = dataGrid.tableCells[i];
					for (var j:int = 0; j < _fixedColumns; j++) {
						var cell:UIBlueText = tableRow[j];
						if (_fixedColumnColours && i >= start) {
							cell.defaultColour = _fixedColumnColours[(rowIndex - start) % _fixedColumnColours.length];
						}
						_fixedColumnSlider.addChild(cell);
					}
					rowIndex++;
				}
			}
			if (dataGrid.hasHeader) {
				var headerRow:Array = dataGrid.tableCells[0];
				for (var k:int = _fixedColumns; k < headerRow.length; k++) {
					_headerSlider.addChild(headerRow[k]);
				}
				if (_fixedColumns > 0) {
					for (var l:int = 0; l < _fixedColumns; l++) {
						_headerFixedColumnSlider.addChild(headerRow[l]);
					}
				}
			}
			if (dataGrid.titleCell) {
				_headerFixedColumnSlider.addChild(dataGrid.titleCell);
			}
		}
		
/**
 *  Create sliding parts of container
 */	
		override protected function createSlider(xml:XML, attributes:Attributes):void {
			var gridAttributes:Attributes = attributes.copy(_dataGridXML);
			_slider = _dataGrid = new UIDataGrid(this, _dataGridXML, gridAttributes);
			_slider.name = "-";
			sliceTable(_dataGrid);
			adjustMaximumSlide();
		}
		
		
		override protected function set sliderX(value:Number):void {
			if (Math.abs(value - _slider.x) < MAXIMUM_DY) {
				_slider.x = value;
				if (_headerSlider) {
					_headerSlider.x = value;
				}
				if (_fixedColumnSlider) {
					_fixedColumnSlider.x = value > 0 ? value : 0;
				}
				if (_headerFixedColumnSlider) {
					_headerFixedColumnSlider.x = value > 0 ? value : 0;
				}
				if (_slider.x > _attributes.width /2) {
					if (_trigger) {
						dispatchEvent(new Event(SWIPE_RIGHT));
						_trigger = false;
					}
				}
				else if (_slider.x < -_maximumSlideX - _attributes.width / 2) {
					if (_trigger) {
						dispatchEvent(new Event(SWIPE_LEFT));
						_trigger = false;
					}
				}
				else {
					_trigger = true;
				}
			}
		}
		
		
		override public function set sliderY(value:Number):void {
			super.sliderY = value;
			if (_fixedColumnSlider) {
				_fixedColumnSlider.y = sliderY;
			}
			_headerFixedColumnSlider.y = value > 0 ? value : 0;
			_headerSlider.y = value > 0 ? value : 0;
		}
		
		
/**
 * Set datagrid data
 */
		public function set gridData(value:Array):void {
			_dataGrid.data = value;
		}
		
/**
 * Refresh datagrid with new data
 */
		public function set dataProvider(value:Array):void {
			_dataGrid.dataProvider = value;
		}
		
/**
 * Refresh datagrid
 */
		public function invalidate(readGrid:Boolean = false):void {
			_dataGrid.invalidate(readGrid);
		}

		
		public function compact(padding:Boolean = false):void {
			_dataGrid.compact(padding);
		}
		
		
		public function get tableCells():Array {
			return _dataGrid.tableCells;
		}
		

		public function get hasHeader():Boolean {
			return _dataGrid.hasHeader;
		}
		
		
		override public function get xml():XML {
			return _dataGridXML;
		}
		
/**
 *  Rearrange the layout to new screen dimensions
 */	
		override public function layout(attributes:Attributes):void {
			_dataGrid.layout(attributes);
			super.layout(attributes);
			if (_fixedColumnSlider) {
				_fixedColumnSlider.graphics.beginFill(_dataGrid.attributes.colour);
				_fixedColumnSlider.graphics.drawRect(_fixedColumnSlider.width, _fixedColumnSlider.getBounds(this).top, 2.0, _fixedColumnSlider.height);
			}
			if (_headerFixedColumnSlider) {
				_headerFixedColumnSlider.graphics.beginFill(_dataGrid.attributes.colour);
				_headerFixedColumnSlider.graphics.drawRect(_headerFixedColumnSlider.width, _headerFixedColumnSlider.getBounds(this).top, 2.0, _headerFixedColumnSlider.height);
			}
		}
		
/**
 * Find a particular row,column (group) inside the grid
 */
		override public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			return _dataGrid.findViewById(id, row, group);
		}
		
		
		override public function destructor():void {
			super.destructor();
			_dataGrid.destructor();
		}
		
	}
}
