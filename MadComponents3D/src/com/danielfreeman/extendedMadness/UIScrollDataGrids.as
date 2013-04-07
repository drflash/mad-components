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
	
	import com.danielfreeman.extendedMadness.*;
import flash.events.TimerEvent;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import com.danielfreeman.madcomponents.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
		import flash.display.InteractiveObject;

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
	public class UIScrollDataGrids extends UIScrollDataGrid {

		protected var _dataGrids:Vector.<UIDataGrid> = new Vector.<UIDataGrid>();
		protected var _fixedColumnLayers:Vector.<Sprite> = new Vector.<Sprite>();
		protected var _currentHeading:int = 0;
		protected var _titleSlider:Sprite = null;


		public function UIScrollDataGrids(screen : Sprite, xml : XML, attributes : Attributes) {
			initialiseLayers(xml);
			super(screen, xml, attributes);
			for (var i:int = 0; i < _slider.numChildren; i++) {
				var child:DisplayObject = _slider.getChildAt(i);
				if (child is UIDataGrid) {
					_dataGrids.push(child);
				}
			}
			this.setChildIndex(_slider, 0);
			layout(attributes);
		}


		protected function reposition(cell:UIBlueText):void {
			var globalPoint:Point = cell.localToGlobal(new Point(0,0));
			var sliderPoint:Point = _slider.globalToLocal(globalPoint);
			cell.x = sliderPoint.x;
			cell.y = sliderPoint.y;
		}
		
		
		protected function initialiseLayers(xml:XML):void {
			addChild(_headerSlider = new Sprite());
			if (xml.@fixedColumns.length() > 0) {
				_fixedColumns = parseInt(xml.@fixedColumns);
				addChild(_fixedColumnSlider = new Sprite());
			}
			addChild(_headerFixedColumnSlider = new Sprite());
			addChild(_titleSlider = new Sprite());
		}
		
		
		protected function sliceTables(dataGrid:UIDataGrid, index:int = 0):void {
			var includeHeaders:Boolean = index == 0;
			var fixedColumnLayer:Sprite;
			if (_fixedColumnLayers.length == index) {
				_fixedColumnSlider.addChild(fixedColumnLayer = new Sprite());
				var dataGridGlobalPoint:Point = dataGrid.localToGlobal(new Point(0,0));
				fixedColumnLayer.y = _slider.globalToLocal(dataGridGlobalPoint).y;
				_fixedColumnLayers.push(fixedColumnLayer);
			}
			else {
				fixedColumnLayer = _fixedColumnLayers[index];
			}
			if (_fixedColumns > 0 && dataGrid.tableCells.length > 0) {
				var rowIndex:int = 0;
				var start:int = dataGrid.hasHeader ? 1 : 0;
				for (var i:int = 0; i < dataGrid.tableCells.length; i++) {
					var tableRow:Array = dataGrid.tableCells[i];
					for (var j:int = 0; j < _fixedColumns; j++) {
						var cell:UIBlueText = tableRow[j];
						if (_fixedColumnColours && i>=start) {
							cell.defaultColour = _fixedColumnColours[(rowIndex - start) % _fixedColumnColours.length];
						}
						fixedColumnLayer.addChild(cell);
					}
					rowIndex++;
				}
			}
			if (includeHeaders && dataGrid.hasHeader) {
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
				if (includeHeaders) {
					_headerFixedColumnSlider.addChild(dataGrid.titleCell);
				}
				else {
					_titleSlider.addChild(dataGrid.titleCell);
					dataGrid.titleCell.y = fixedColumnLayer.y;
				}
			}
		}

		
		
		protected function sliceAllTables():void {
			for (var i:int = 0; i < _slider.numChildren; i++) {
				var child:DisplayObject = _slider.getChildAt(i);
				if (child is UIDataGrid) {
					sliceTables(UIDataGrid(child), i);
				}
			}
		}
		
		
		protected function swapHeaders():void {
			var index:int = -1;
			if (_slider.y < 0) { 
				while (index + 1 < _fixedColumnLayers.length && -_slider.y + (_currentHeading >=0 ? _headerFixedColumnSlider.getBounds(this).bottom / 2 : 0)> _fixedColumnLayers[index + 1].y) {
					index++;
				}
			}
			if (index != _currentHeading) {
				if (_currentHeading >= 0) {
					var dataGridOld:UIDataGrid = _dataGrids[_currentHeading];
					var fixedColumnLayerOld:Sprite = _fixedColumnLayers[_currentHeading];
					if (dataGridOld.hasHeader) {
						var headingRowOld:Array = dataGridOld.tableCells[0];
						for (var i:int =0; i < _fixedColumns; i++) {
							fixedColumnLayerOld.addChild(headingRowOld[i]);
						}
						for (var j:int = _fixedColumns; j < headingRowOld.length; j++) {
							dataGridOld.addChild(headingRowOld[j]);
						}
					}
					if (dataGridOld.titleCell) {
						_titleSlider.addChild(dataGridOld.titleCell);
						dataGridOld.titleCell.y = _fixedColumnLayers[_currentHeading].y;
					}
				}
				if (index >= 0) {
					var dataGridNew:UIDataGrid = _dataGrids[index];
					if (dataGridNew.hasHeader) {
						var headingRowNew:Array = dataGridNew.tableCells[0];
						for (var k:int =0; k < _fixedColumns; k++) {
							_headerFixedColumnSlider.addChild(headingRowNew[k]);
						}
						for (var l:int = _fixedColumns; l < headingRowNew.length; l++) {
							_headerSlider.addChild(headingRowNew[l]);
						}
					}
					headerFixedColumnLine(index);
					if (dataGridNew.titleCell) {
						_headerFixedColumnSlider.addChild(dataGridNew.titleCell);
						dataGridNew.titleCell.y = 0;
					}
				}
				
				_currentHeading = index;
			}
		}
		
		
		override protected function set sliderX(value:Number):void {
			super.sliderX = value;
			_titleSlider.x = value < 0 ? 0 : value;
		}
		
		
		override public function set sliderY(value:Number):void {
			super.sliderY = value;
			_titleSlider.y = value;
			swapHeaders();
		}

/**
 *  Create sliding parts of container
 */	
		override protected function createSlider(xml:XML, attributes:Attributes):void {
			_slider = new UI.FormClass(this, _dataGridXML, sliderAttributes(attributes));
			_slider.name = "-";
			adjustMaximumSlide();
			sliceAllTables();
		}
		
		
		protected function headerFixedColumnLine(index:int):void {
			if (_currentHeading >= 0) {
				var dataGrid:UIDataGrid = _dataGrids[index];
				if (dataGrid.tableCells.length > 0) {
					_headerFixedColumnSlider.graphics.clear();
					_headerFixedColumnSlider.graphics.beginFill(dataGrid.attributes.colour);
					_headerFixedColumnSlider.graphics.drawRect(dataGrid.tableCells[0][_fixedColumns].x, _headerFixedColumnSlider.getBounds(this).top, 2.0, _headerFixedColumnSlider.height);
				}
			}
		}
		
		
		public function selectDataGridIndex(value:int):void {
			_dataGrid = _dataGrids[value];
		}
		
/**
 *  Rearrange the layout to new screen dimensions
 */	
		override public function layout(attributes:Attributes):void {
			_attributes = attributes;
			IContainerUI(_slider).layout(sliderAttributes(attributes));
			var index:int = 0;
			for each(var fixedColumnLayer:Sprite in _fixedColumnLayers) {
				fixedColumnLayer.graphics.clear();
				fixedColumnLayer.graphics.beginFill(_dataGrids[index].attributes.colour);
				fixedColumnLayer.graphics.drawRect(fixedColumnLayer.width, fixedColumnLayer.getBounds(fixedColumnLayer).top, 2.0, fixedColumnLayer.height);
				index++;
			}
			headerFixedColumnLine(_currentHeading);
			drawComponent();
			adjustMaximumSlide();
			refreshMasking();
		}
		
/**
 * Find a particular row,column (group) inside the grid
 */
		override public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			for each (var dataGrid:UIDataGrid in _dataGrids) {
				var result:DisplayObject = dataGrid.findViewById(id, row, group);
				if (result) {
					return result;
				}
			}
			return null;
		}
		
		
		override public function destructor():void {
			super.destructor();
		}
		
	}
}
