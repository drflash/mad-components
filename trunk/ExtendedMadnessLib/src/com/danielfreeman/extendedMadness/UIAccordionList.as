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
	public class UIAccordionList extends UIDividedList {/*THIS METHOD IS UNDOCUMENTED AND DEPRECIATED*/
		
		protected static const CENTRE:Number = 22.0;
		protected static const ARROW:Number = 4.0;
		
		protected var _alt:Boolean = false;
		protected var _arrowColour:uint = 0x333333;
	
		public function UIAccordionList(screen:Sprite, xml:XML, attributes:Attributes) {
			_alt = xml.@alt == "true";
			if (xml.@arrowColour.length() > 0) {
				_arrowColour = UI.toColourValue(xml.@arrowColour);
			}
			xml.@autoLayout = "false";
			xml.@gapV = "8";
			xml.@groupSpacing[0] = "6";
			attributes.parse(xml);
			super(screen, xml, attributes);
			if (xml.@inactiveColour.length() > 0) {
				_headingOffColour = UI.toColourValue(xml.@inactiveColour);
			}
		//	_autoLayoutGroup = false;
			_groupSpacing = 6;
		}
		
		
		public function collapse():void {
			var groupIndex:int = 0;
			for each(var groupDetails:Object in _groupPositions) {
				for (var i:int = 0; i < groupDetails.length; i++) {
					var cell:DisplayObject = _slider.getChildByName("label_"+i.toString()+"_"+groupIndex.toString());	
					cell.visible = false;
					cell.y = -groupDetails.cellHeight;
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
					cell.y = -groupDetails.cellHeight;
				}
			//	cell.y = visible ? groupDetails.cellHeight*i + groupDetails.top : 0;
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
		
	/*	override protected function redrawCells():void {
			var autoLayout:Boolean = _alwaysAutoLayout || !_simple && _autoLayoutGroup;
			setCellSize();
			var saveGroup:int = _group;
			_group = 0;
			var last:Number = _top-1.5*_attributes.paddingV + (_autoLayoutGroup ? 2*_attributes.paddingV : 0);
			for each(var groupDetails:Object in _groupPositions) {
				_length = groupDetails.length;
				if (autoLayout) {
					groupDetails.top = last;
					var heading:DisplayObject = _slider.getChildByName("heading_"+_group.toString());
					if (heading) {
						heading.y = last + 2*_attributes.paddingV + 2;
						last = groupDetails.top = Math.max(heading.y + heading.height, last + 3*_attributes.paddingV) + _attributes.paddingV;
						var shadow:DisplayObject = _slider.getChildByName("shadow_"+_group.toString());
						if (shadow) {
							shadow.y = heading.y + 1;
						}
					}
				}
				_cellTop = groupDetails.top;
				headingChrome();
				if (groupDetails.visible) {
					var cellHeight:Number;
					for (var i:int=0; i<_length; i++) {
						cellHeight = groupDetails.cellHeight;
						if (autoLayout) {
							var renderer:DisplayObject = byGroupAndRow(_group,i);
							if (!_simple) {
								cellHeight = renderer.height + 2 * _attributes.paddingV;
							}
							renderer.y = last + _attributes.paddingV * (_simple ? 2.0 : 1.0);
							last += cellHeight;
	
						}
						if (cellHeight > 0) {
							var record:Object = _filteredData[_group][i];
							drawCell(_cellTop + cellHeight, i, record);
						}
					}
				//	last += _groupSpacing - cellHeight;
				}
				_group++;
			//	last += (_xml.@groupSpacing.length() > 0) ? _groupSpacing - 2 * _gapBetweenGroups - groupDetails.cellHeight + 8 : _attributes.paddingV;
			//	last += (_xml.@groupSpacing.length() > 0) ? _groupSpacing - 2 * _gapBetweenGroups + 8 : _attributes.paddingV;
				last += _groupSpacing;
				
				if (!_simple && autoLayout && groupDetails.visible) {
				//	last += _groupSpacing; //2 * _gapBetweenGroups;// + 4 * _attributes.paddingV - 4;
				//	groupDetails.bottom = last - (_alwaysAutoLayout ? _gapBetweenGroups : 0);
					groupDetails.bottom = last;
				}
				if (_alwaysAutoLayout && (_simple || !groupDetails.visible)) {
					groupDetails.bottom = last;
					last += 2.0*_gapBetweenGroups;
				}
			}
			_group = saveGroup;
		}*/
		
		
		override protected function redrawCells():void {
			_alwaysAutoLayout = true;
			_slider.graphics.clear();
			super.redrawCells();
			_slider.graphics.beginFill(_arrowColour);
			var bottom:Number = 0;
			for each(var detail:Object in _groupPositions) {
				var position:Number = (detail.top + bottom) / 2 + ((bottom == 0) ? 0  : 4);
				var wayUp:Number = detail.visible ? -1.0 : 1.0;
				_slider.graphics.moveTo(_attributes.width - CENTRE, position - wayUp * ARROW);
				_slider.graphics.lineTo(_attributes.width - CENTRE + ARROW, position + wayUp * ARROW);
				_slider.graphics.lineTo(_attributes.width - CENTRE - ARROW, position + wayUp * ARROW);
				bottom = detail.bottom - (detail.visible ? 0 : _attributes.paddingV);
				if (detail.visible) {
					bottom -= _attributes.paddingV;
				}
			}
			_slider.graphics.endFill();
			calculateMaximumSlide();
		}
	}
}
