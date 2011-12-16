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
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextFormat;
	

	public class UICutCopyPaste extends MadSprite
	{
		protected static const HEIGHT:Number = 38.0;
		protected static const ALT_HEIGHT:Number = 22.0;
		protected static const GAP:Number = 10.0;
		protected static const CURVE:Number = 16.0;
		protected static const ARROW:Number = 14.0;
		protected static const COLOUR:uint = 0x555555;
		protected static const FORMAT:TextFormat = new TextFormat("_sans",16,0xFFFFFF);
		
		protected var _labels:Vector.<UILabel> = new Vector.<UILabel>();
		protected var _index:int = -1;
		protected var _colour:uint = COLOUR;
		protected var _gap:Number = GAP;
		protected var _curve:Number = CURVE;
		protected var _height:Number = HEIGHT;
		protected var _alt:Boolean;
		protected var _font:XML = null;
		
/**
 * Cut / Copy / Paste style buttons
 */
		public function UICutCopyPaste(screen:Sprite, xx:Number, yy:Number, colour:uint = 0x666666, alt:Boolean = false)
		{
			screen.addChild(this);
			x=xx;y=yy;
			_colour = colour;
			_height = alt ? ALT_HEIGHT : HEIGHT;
			initialise();
			buttonMode=useHandCursor = true;
			addEventListener(MouseEvent.MOUSE_UP,mouseUp);
		}
		
		
		public function set font(value:XML):void {
			_font = value;
		}
		
		
		protected function initialise():void {
			drawButtons(new <String>["Cut","Copy","Paste"],50);
		}
		
		
		protected function mouseUp(event:MouseEvent):void {
			updateIndex();
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		protected function updateIndex():void {
			for (var i:int = _labels.length-1; i>=0 ; i--) {
				var position:Number = _labels[i].x - _gap;
				if (mouseX>position) {
					_index = i;
					return;
				}
			}
			_index = 0;
		}
		
/**
 * Get the index of the button clicked
 */
		public function get index():int {
			return _index;
		}
		
		
		protected function drawButtons(labels:Vector.<String>, arrowPosition:Number = -1):void {
			var left:Number = 0;
			for each (var label:String in labels) {
				var uiLabel:UILabel = new UILabel(this, left+_gap, 0, "", FORMAT);
				if (_font) {
					uiLabel.htmlText = _font.toXMLString().substr(0,_font.toXMLString().length-2)+ ">" + label + "</font>";
				}
				else {
					uiLabel.text = label;
				}
				uiLabel.y = (_height - uiLabel.height) / 2;
				left += uiLabel.width + 2*_gap;
				_labels.push(uiLabel);
			}
			buttonChrome(left, arrowPosition);
		}

			
		protected function buttonChrome(left:Number, arrowPosition:Number = -1):void {
			var matr:Matrix = new Matrix();
			var gradient:Array = [Colour.lighten(_colour,128),_colour,_colour];
			matr.createGradientBox(left, _height, Math.PI/2, 0, 0);
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, gradient, [1.0,1.0,1.0], [0x00,0x80,0xff], matr);
			graphics.lineStyle(1, Colour.darken(_colour,-32), 1.0, true);
			graphics.moveTo(0,_curve);
			graphics.curveTo(0, 0, _curve, 0);
			graphics.lineTo(left - _curve, 0);
			graphics.curveTo(left, 0, left, _curve);
			graphics.lineTo(left, _height - _curve);
			graphics.curveTo(left, _height, left - _curve, _height);
			if (arrowPosition>=0) {
				graphics.lineTo(arrowPosition + ARROW, _height);
				graphics.lineTo(arrowPosition, _height + ARROW);
				graphics.lineTo(arrowPosition - ARROW, _height);
			}
			graphics.lineTo(_curve, _height);
			graphics.curveTo(0, _height, 0, _height - _curve);
			graphics.lineTo(0, _curve);
			
			graphics.lineStyle(0,0,0);
			for (var i:int = 1; i < _labels.length; i++) {
				var position:Number = _labels[i].x;
				graphics.beginGradientFill(GradientType.LINEAR, [Colour.lighten(_colour,126), _colour], [1.0,1.0], [0x00,0xff], matr);
				graphics.drawRect(position - _gap, 1, 1, _height-1);
				graphics.beginGradientFill(GradientType.LINEAR, [Colour.darken(_colour), _colour], [1.0,1.0], [0x00,0xff], matr);
				graphics.drawRect(position - _gap + 1, 1, 1, _height-1);
			}
		}
		
		
		public function destructor():void {
			removeEventListener(MouseEvent.MOUSE_UP,mouseUp);
		}
	}
}