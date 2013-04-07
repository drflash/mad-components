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

package com.danielfreeman.extendedMadness {
	 
	import com.danielfreeman.madcomponents.*;
	import flash.display.Sprite;
	import flash.display.DisplayObject;

/**
 * Accordion list component
 * <pre>
 * &lt;dividedList
 *    id = "IDENTIFIER"
 *    colour = "#rrggbb"
 *    background = "#rrggbb, #rrggbb, ..."
 *    visible = "true|false"
 *    gapV = "NUMBER"
 *    gapH = "NUMBER"
 *    border = "true|false"
 *    lines = "true|false"
 *    pullDownRefresh = "true|false"
 *    pullDownColour = "#rrggbb"
 *    sortBy = "IDENTIFIER"
 *    mask = "true|false"
 *    alignV = "scroll|no scroll"
 *    highlightPressed = "true|false"
 *    autoLayout = "true|false"
 *    headingColour = "#rrggbb"
 *    headingTextColour = "#rrggbb"
 *    headingShadowColour = "#rrggbb"
 *    arrowColour = "#rrggbb"
 *    alt = "true|false"
 * /&gt;
 * </pre>
 */
	public class UIAccordionList extends UIDividedList {
		
		protected static const CENTRE:Number = 20.0;
		protected static const ARROW:Number = 4.0;
		
		protected var _alt:Boolean = false;
		protected var _arrowColour:uint = 0xCCCCCC;
	
		public function UIAccordionList(screen:Sprite, xml:XML, attributes:Attributes) {
			_alt = xml.@alt == "true";
			if (xml.@arrowColour.length() > 0) {
				_arrowColour = UI.toColourValue(xml.@arrowColour);
			}
			super(screen, xml, attributes);
			if (xml.@inactiveColour.length() > 0) {
				_headingOffColour = UI.toColourValue(xml.@inactiveColour);
			}
		}
		
		
		public function collapse():void {
			var groupIndex:int = 0;
			for each(var groupDetails:Object in _groupPositions) {
				for (var i:int = 0; i < groupDetails.length; i++) {
					var cell:DisplayObject = _slider.getChildByName("label_"+i.toString()+"_"+groupIndex.toString());	
					cell.visible = false;
					cell.y = 0;
				}
				groupDetails.visible = false;
				groupIndex++;
			}
			redrawCells();
		}
		
		
		public function groupVisible(groupIndex:int, visible:Boolean = true):void {
			if (_alt) {
				collapse();
			}
			var groupDetails:Object = _groupPositions[groupIndex];
			groupDetails.visible = visible;
			for (var i:int = 0; i < groupDetails.length; i++) {
				var cell:DisplayObject = _slider.getChildByName("label_"+i.toString()+"_"+groupIndex.toString());	
				cell.visible = visible;
				if (!visible) {
					cell.y = 0;
				}
			}
			redrawCells();
		}
		
		
		public function toggle(groupIndex:int):void {
			groupVisible(groupIndex, !_groupPositions[groupIndex].visible);
		}
		
		
		override protected function headingClicked():void {
			super.headingClicked();
			if (group < _groupPositions.length) {
				toggle(group);
			}
		}
		

		override protected function redrawCells():void {
			_alwaysAutoLayout = true;
			_slider.graphics.clear();
			super.redrawCells();
			_slider.graphics.beginFill(_arrowColour);
			for each(var detail:Object in _groupPositions) {
				if (!detail.visible) {
					detail.bottom -= _attributes.paddingV;
				}
				var wayUp:Number = detail.visible ? -1.0 : 1.0;
				_slider.graphics.moveTo(_attributes.width - CENTRE, detail.top - CENTRE - wayUp * ARROW);
				_slider.graphics.lineTo(_attributes.width - CENTRE + ARROW, detail.top - CENTRE + wayUp * ARROW);
				_slider.graphics.lineTo(_attributes.width - CENTRE - ARROW, detail.top - CENTRE + wayUp * ARROW);
			}
			_slider.graphics.endFill();
			calculateMaximumSlide();
		}
	}
}
