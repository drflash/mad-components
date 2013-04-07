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
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import com.danielfreeman.madcomponents.*;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.InteractiveObject;

/**
 * ScrollTouchGrids component
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
	public class UIScrollTouchGrids extends UIScrollDataGrids {
		
		public static const EDIT_BUTTON_PRESSED:String = "editButtonPressed";
		public static const ROW_SELECTED:String = "rowSelected";
		
		protected static const ROW_SELECT_COLOUR:uint = 0xAAAAFF;
		protected static const EDIT_BUTTON_COLOUR:uint = 0x9999CC;
		protected static const EDIT_BUTTON_RADIUS:Number = 32.0;
		protected static const EDIT_BUTTON_LINE_COLOUR:uint = 0xDDDDFF;
		protected static const EDIT_BUTTON_CENTRE_COLOUR:uint = 0x8888BB;
		protected static const EDIT_BUTTON_CENTRE_RADIUS:Number = 16.0;
		
		protected var _clickDelay:Timer = new Timer(100, 1);
		protected var _rowSelectTimer:Timer = new Timer(100);
		protected var _editButtonTimer:Timer = new Timer(1000, 1);
		protected var _rowSelectColour:uint = ROW_SELECT_COLOUR;
		protected var _highlightedRowIndex:int = -1;
		protected var _highlightedDataGrid:UIDataGrid = null;
		protected var _originalNoScroll:Boolean;
		protected var _editButton:Boolean = false;
		protected var _editButtonIcon:Sprite;
		protected var _clickedRowIndex:int;

		
		public function UIScrollTouchGrids(screen : Sprite, xml : XML, attributes : Attributes) {
			super(screen, xml, attributes);
			_clickDelay.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			_rowSelectTimer.addEventListener(TimerEvent.TIMER, rowSelectHandler);
			_editButtonTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hideEditButtonHandler);
			_originalNoScroll = _noScroll;
			initialiseEditButton();
		}
		
		
		public function set rowSelectColour(value:uint):void {
			_rowSelectColour = value;
		}
		
		
		override public function set scrollEnabled(value:Boolean):void {
			super.scrollEnabled = value;
			_originalNoScroll = _noScroll;
		}
		
		
		protected function initialiseEditButton():void {
			addChild(_editButtonIcon = new Sprite());
			_editButtonIcon.graphics.beginFill(EDIT_BUTTON_COLOUR);
			_editButtonIcon.graphics.drawCircle(0, 0, EDIT_BUTTON_RADIUS);
			_editButtonIcon.graphics.lineStyle(2, EDIT_BUTTON_LINE_COLOUR);
			_editButtonIcon.graphics.beginFill(EDIT_BUTTON_CENTRE_COLOUR);
			_editButtonIcon.graphics.drawCircle(0, 0, EDIT_BUTTON_CENTRE_RADIUS);
			_editButtonIcon.visible = false;
		}
		
		
		public function showEditButton(x: Number, y: Number):void {
			_editButtonIcon.x = x;
			_editButtonIcon.y = y;
			_editButtonIcon.visible = true;
		}
		
		
		public function hideEditButton():void {
			_editButtonIcon.visible = false;
			clearHighlightRow();
			_highlightedRowIndex = -1;
		}
		
		
		public function hideEditButtonHandler(event:TimerEvent):void {
			hideEditButton();

		}
		
		
		protected function yToDataGrid(y:Number):UIDataGrid {
			var index:int = 0;
			while (index + 1 < _dataGrids.length && y > _dataGrids[index + 1].y) {
				index ++;
			}
			return index >= 0 ? _dataGrids[index] : null;
		}
		
		
		protected function clearHighlightRow():void {
			if (_highlightedDataGrid && _highlightedRowIndex >= 0) {
				_highlightedDataGrid.restoreRow(_highlightedRowIndex);
				var tableRow:Array = _highlightedDataGrid.tableCells[_highlightedRowIndex];
				var start:int = (_highlightedDataGrid.hasHeader ? 1.0 : 1.0);
				if (_fixedColumnColours && _highlightedRowIndex >= start) {
					for (var j:int = 0; j < _fixedColumns; j++) {
						UIBlueText(tableRow[j]).defaultColour = _fixedColumnColours[(_highlightedRowIndex - start) % _fixedColumnColours.length];
					}
				}
			}
		}
		
		
		protected function setHighlightRow():void {
			if (_highlightedDataGrid && _highlightedRowIndex >= 0) {
				_highlightedDataGrid.colourRow(_highlightedRowIndex, _rowSelectColour);
			}
		}
		
		
		protected function rowSelectHandler(event:TimerEvent = null):void {
			var highlightedDataGrid:UIDataGrid = yToDataGrid(_slider.mouseY);
			var highlightedRowIndex:int = highlightedDataGrid ? highlightedDataGrid.yToRow(highlightedDataGrid.mouseY) : -1;
			if (highlightedDataGrid != _highlightedDataGrid || highlightedRowIndex != _highlightedRowIndex) {
				clearHighlightRow();
				_highlightedDataGrid = highlightedDataGrid;
				_highlightedRowIndex = highlightedRowIndex;
				setHighlightRow();
			}
		}

		
/**
 * Mouse down handler
 */
		override protected function mouseDown(event:MouseEvent):void {
			hideEditButton();
			if (event.target == _editButtonIcon) {
				dispatchEvent(new Event(EDIT_BUTTON_PRESSED));
			}
			else {
				_editButtonTimer.stop();
				super.mouseDown(event);
				_clickDelay.reset();
				_clickDelay.start();
			}
			
		}
		
		
		override protected function mouseUp(event:MouseEvent):void {
			super.mouseUp(event);
			if (_rowSelectTimer.running) {
				_noScroll = _originalNoScroll;
				_rowSelectTimer.stop();
				_clickedRowIndex = _highlightedRowIndex;
				_dataGrid = _highlightedDataGrid;
				if (_editButton) {
					showEditButton(mouseX, mouseY);
					_editButtonTimer.reset();
					_editButtonTimer.start();
				}
				else {
					hideEditButton();
				}
				dispatchEvent(new Event(ROW_SELECTED));
			}
		}
		
		
		public function get index():int {
			return _clickedRowIndex;
		}
		
		
		protected function timerComplete(event:TimerEvent):void {
			if (_distance < THRESHOLD) {
				_noScroll = true;
				rowSelectHandler();
				_rowSelectTimer.start();
			}
		}
		
		
		override public function destructor():void {
			super.destructor();
			_clickDelay.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			_rowSelectTimer.removeEventListener(TimerEvent.TIMER, rowSelectHandler);
			_editButtonTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, hideEditButtonHandler);
		}
		
	}
}
