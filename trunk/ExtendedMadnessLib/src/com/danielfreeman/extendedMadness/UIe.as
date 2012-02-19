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

	import asfiles.Cursor;
	import asfiles.HintText;
	
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class UIe extends UI {

		protected static const DESKTOP_TOKENS:Array = ["tabPagesTop","scrollXY","scrollBarVertical","scrollBarHorizontal","scrollBarPanel","dataGrid","menu","segmentedControl","checkBox","radioButton","treeNavigation","pieChart","barChart","lineChart","scatterChart","horizontalChart","splitView","starRating","field"];
		protected static const DESKTOP_CLASSES:Array = [UITabPagesTop,UIScrollXY,UIScrollBarVertical,UIScrollBarHorizontal,UIScrollBarPanel,UIDataGrid,UIMenu,UISegmentedControl,UICheckBox,UIRadioButton,UITreeNavigation,UIPieChart,UIBarChart,UILineChart,UIScatterChart,UIHorizontalChart,UISplitView,UIStarRating,UIField];
		
		protected static var _cursor:Cursor = null;
		
		public static function activate(screen:Sprite):void {
			_FormClass = UIPanel;
			extend(DESKTOP_TOKENS,DESKTOP_CLASSES);
			HintText.SIZE = 30;
			Cursor.HINT_Y = 64;
			_cursor = new Cursor(screen);
		}
		
/**
 * Create a UI layout in a resizable window
 */
		public static function createInWindow(screen:Sprite, xml:XML):Sprite {
			if (!_cursor)
				activate(screen);
			var result:Sprite = create(screen, xml, screen.stage.stageWidth, screen.stage.stageHeight);
			if (xml.@autoResize!="false")
				screen.stage.addEventListener(Event.RESIZE,resize);
			if (_root.mask) {
				_root.removeChild(_root.mask);
				_root.mask = null;
			}
			screen.setChildIndex(_cursor,screen.numChildren-1);
			return result;
		}
		
/**
 * Create a UI layout with extended components
 */
		public static function create(screen:Sprite, xml:XML, width:Number = -1, height:Number = -1):Sprite {
			if (!_cursor)
				activate(screen);
			var result:Sprite = UI.create(screen, xml, width, height);
			screen.setChildIndex(_cursor,screen.numChildren-1);
			return result;
		}
	}
}
