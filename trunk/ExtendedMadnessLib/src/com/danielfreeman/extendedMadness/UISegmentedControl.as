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

package com.danielfreeman.extendedMadness
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
/**
 * Segmented Control
 * <pre>
 * &lt;segmentedControl
 *    id = "IDENTIFIER"
 *    background = "#rrggbb, #rrggbb, ..."
 *    alignH = "left|right|centre|fill"
 *    alignV = "top|bottom|centre|fill"
 *    visible = "true|false"
 * 	  alt = "true|false"
 * /&gt;
 * </pre>
 * */
	public class UISegmentedControl extends UICutCopyPaste implements IContainerUI
	{
		protected static const BUTTON_COLOUR:uint = 0xE6E6E6; //0xAFAFAF;
		protected static const PRESSED_COLOUR:uint = 0x6666CC;
		protected static const TEXT_COLOUR:uint = 0x666666;
		protected static const PRESSED_TEXT_COLOUR:uint = 0xFFFFFF;
		protected static const CONTROL_CURVE:Number = 12.0;
		
		protected var _attributes:Attributes;
		protected var _xml:XML;
		protected var _pressedLayer:Sprite;
		protected var _pressedColour:uint = PRESSED_COLOUR;
		
		
		public function UISegmentedControl(screen:Sprite, xml:XML, attributes:Attributes)
		{
			_xml = xml;
			_attributes = attributes;
			if (xml.font.length()>0)
				_font = xml.font[0];
			addChild(_pressedLayer = new Sprite());
			var colour:uint = attributes.backgroundColours.length>0 ? attributes.backgroundColours[0] : BUTTON_COLOUR;
			_pressedColour = attributes.backgroundColours.length>1 ? attributes.backgroundColours[1] : PRESSED_COLOUR;
			super(screen, 0, 0, colour, xml.@alt == "true");
			colourButtons();
			if (attributes.fillH)
				fixwidth = attributes.widthH;
			index=0;
		}
		
		
/**
 * Set index of active segment
 */	
		public function set index(value:int):void {
			if (_index>=0 && !_font)
				_labels[_index].textColor = TEXT_COLOUR;
			_index = value;
			showPressed();
		}
		
/**
 * Set width of component
 */
		public function set fixwidth(value:Number):void {
			var textWidth:Number = 0;
			for each (var label0:UILabel in _labels)
				textWidth+=label0.width;
			_gap = (value-textWidth)/(2*_labels.length);
			var left:Number = _gap;
			for each (var label1:UILabel in _labels) {
				label1.x = left;
				left+=label1.width + 2*_gap;
			}
			buttonChrome(value);
			showPressed();
		}
		
		
		public function layout(attributes:Attributes):void {
			_attributes = attributes;
			if (attributes.fillH)
				fixwidth = attributes.widthH;
		}
		
		
		override protected function initialise():void {
			_curve = attributes.backgroundColours.length>2 ? attributes.backgroundColours[2] : CONTROL_CURVE;
			if (_xml.data.length()==1) {
				drawButtons(extractData(_xml.data[0]));
			}
		}
		
		
		protected function extractData(xml:XML):Vector.<String> {
			var result:Vector.<String> = new Vector.<String>();
			for each (var item:XML in xml.children()) {
				if (item.@label.length()>0)
					result.push(item.@label.toString());
				else
					result.push(item.localName());
			}
			return result;
		}
		
		
		override protected function mouseUp(event:MouseEvent):void {
			if (_index>=0 && !_font)
				_labels[_index].textColor = TEXT_COLOUR;
			super.mouseUp(event);
			showPressed();
		}
		
		
		protected function colourButtons():void {
			if (!_font)
				for each (var label:UILabel in _labels) {
					label.textColor = TEXT_COLOUR;
				}
		}
		
		
		protected function showPressed():void {
			var matr:Matrix = new Matrix();
			_pressedLayer.graphics.clear();
			matr.createGradientBox(width, _height, Math.PI/2, 0, 0);
			_pressedLayer.graphics.beginGradientFill(GradientType.LINEAR, [Colour.darken(_pressedColour,-32),_pressedColour,Colour.lighten(_pressedColour,48),Colour.lighten(_pressedColour,48)], [1.0,1.0,1.0,1.0], [0x00,0x20,0x80,0xff], matr);
			if (_index<0) {
				return;
			}
			else if (_labels.length==1) {
				_pressedLayer.graphics.drawRoundRect(1, 1, width-2, _height-1,_curve);
			}
			else if (_index==0) {
				var right:Number = _labels[1].x - _gap +1;
				_pressedLayer.graphics.moveTo(1, _curve);
				_pressedLayer.graphics.curveTo(1, 1, _curve, 1);
				_pressedLayer.graphics.lineTo(right, 1);
				_pressedLayer.graphics.lineTo(right, _height);
				_pressedLayer.graphics.lineTo(_curve, _height);
				_pressedLayer.graphics.curveTo(1, _height, 1, _height - _curve);
				_pressedLayer.graphics.lineTo(1, _curve-1);
			}
			else if (_index==_labels.length-1) {
				var left:Number = _labels[_index].x - _gap +2;
				_pressedLayer.graphics.moveTo(left, 1);
				_pressedLayer.graphics.lineTo(width-_curve, 1);
				_pressedLayer.graphics.curveTo(width-1, 1, width-1, _curve);
				_pressedLayer.graphics.lineTo(width-1, _height-_curve);
				_pressedLayer.graphics.curveTo(width-1, _height, width-_curve-1, _height);
				_pressedLayer.graphics.lineTo(left, _height);
				_pressedLayer.graphics.lineTo(left, 1);
			}
			else {
				var left0:Number = _labels[_index].x - _gap + 2;
				var width0:Number = _labels[_index].width + 2*_gap - 1;
				_pressedLayer.graphics.drawRect(left0, 1, width0, _height-1);
			}
			if (!_font)
				_labels[_index].textColor = PRESSED_TEXT_COLOUR;
		}
		
		
		public function get attributes():Attributes {
			return _attributes;
		}
		
		
		public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			return null;
		}
		
		
		public function clear():void {
			for each (var label:UILabel in _labels)
				removeChild(label);
			_labels = new <UILabel>[];
		}
		
		
		public function get pages():Array {
			return [];
		}
		
		
		public function get xml():XML {
			return _xml;
		}
	}
}