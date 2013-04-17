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
	
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.Shape;
	import com.danielfreeman.madcomponents.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.GradientType;
	import flash.geom.Matrix;

/**
 *  MadComponent label scroller
 * <pre>
 * &lt;slider
 *   id = "IDENTIFIER"
 *   alignH = "left|right|centre|fill"
 *   alignV = "top|bottom|centre"
 *   visible = "true|false"
 *   mask = "true|false"
 *   width = "NUMBER"
 *   colour = "#rrggbb"
 *   curve = "NUMBER"
 *   <font>
 *   <data>
 * /&gt;
 * </pre>
 */
	public class UILabelScroller extends UIContainerBaseClass {
		
		protected static const ARROW_COLOUR:uint = 0xCCCCFF;
		protected static const ARROW_OFFSET:Number = 10.0;
		protected static const ARROW_WIDTH:Number = 5.0;
		protected static const ARROW_HEIGHT:Number = 20.0;
		protected static const SCROLL_INCREMENT:Number = 30.0;
		protected static const ANIMATE_STEPS:int = 3;
		protected static const ALPHA:Number = 0.5;
		protected static const SENSOR:Number = 32.0;
		protected static const GAP:Number = 5.0;
		
		protected var _data:Vector.<String>;
		protected var _font:XML = null;
		protected var _index:int = 0;
		protected var _labelLayer:UILabel;
		protected var _arrowLayer:Shape;
		protected var _arrowColour:uint = ARROW_COLOUR;
		protected var _timer:Timer = new Timer(100);
		protected var _slideOutTimer:Timer = new Timer(50, ANIMATE_STEPS);
		protected var _slideInTimer:Timer = new Timer(50, ANIMATE_STEPS);
		protected var _distance:Number = 0;
		protected var _lastX:Number;
		protected var _step:Number;
		protected var _nextIndex:int;
		protected var _midPoint:Number;
		protected var _curve:Number;
		
		
		public function UILabelScroller(screen:Sprite, xml:XML, attributes:Attributes) {
			_attributes = attributes;
			addChild(_arrowLayer = new Shape());
			_labelLayer = new UILabel(this, 0, 0);
			if (xml.@arrowColour.length() > 0) {
				_arrowColour = UI.toColourValue(xml.@arrowColour);
			}
			if (xml.font.length() > 0) {
				_font = xml.font[0];
			}
			if (xml.data.length() > 0) {
				xmlData = xml.data[0];
			}
			if (xml.@mask == "true") {
				addChild(mask = new Sprite());
			}
			super(screen, xml, attributes);
			_timer.addEventListener(TimerEvent.TIMER, mouseMove);
			_slideOutTimer.addEventListener(TimerEvent.TIMER, moveLabel);
			_slideOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, slideOutComplete);
			_slideInTimer.addEventListener(TimerEvent.TIMER, moveLabel);
			buttonMode = useHandCursor = true;
			_arrowLayer.alpha = ALPHA;
		}
		
		
		protected function applyMask():void {
			if (mask) {
				Sprite(mask).graphics.clear();
				Sprite(mask).graphics.beginFill(0);
				Sprite(mask).graphics.drawRect(0, 0, _attributes.widthH, _labelLayer.height);
			}
		}
		
		
		protected function animateTransition(direction:Boolean):void {
			  _nextIndex = _index + (direction ? 1 : -1);
			  if (_nextIndex < 0) {
				_nextIndex = _data.length - 1;
			  }
			  else if (_nextIndex >= _data.length) {
				_nextIndex = 0;
			  }
			  _step = ((direction ? _attributes.widthH : -_labelLayer.width) - _labelLayer.x) / ANIMATE_STEPS;
			  _slideOutTimer.reset();
			  _slideOutTimer.start();
		}
		
		
		protected function moveLabel(event:TimerEvent):void {
			_labelLayer.x += _step;
		}
		
		
		protected function slideOutComplete(event:TimerEvent):void {
			_slideOutTimer.stop();
			text = _data[_nextIndex];
			_index = _nextIndex;
			_midPoint = (_attributes.widthH - _labelLayer.width) / 2;
			_labelLayer.x = _midPoint - ANIMATE_STEPS * _step;
			_slideInTimer.reset();
			_slideInTimer.start();
		}
		
		
		override public function drawComponent():void {
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(_attributes.widthH, _labelLayer.height, Math.PI/2, 0, 0);
			_curve = (_xml.@curve.length() > 0) ? parseFloat(_xml.@curve) : _labelLayer.height;
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, [Colour.darken(_attributes.colour,-64), _attributes.colour, Colour.lighten(_attributes.colour,64),Colour.lighten(_attributes.colour,64)], [1.0,1.0,1.0,1.0], [0x00,0x00,0x80,0xff], matr);
			graphics.drawRoundRect(0, 0, _attributes.widthH, _labelLayer.height, _curve);
			
			_arrowLayer.graphics.clear();
			_arrowLayer.graphics.beginFill(_arrowColour);
			_arrowLayer.graphics.moveTo(GAP, _labelLayer.height / 2);
			_arrowLayer.graphics.lineTo(GAP + ARROW_OFFSET, GAP);
			_arrowLayer.graphics.lineTo(GAP + ARROW_WIDTH + ARROW_OFFSET, GAP);
			_arrowLayer.graphics.lineTo(GAP + ARROW_OFFSET, _labelLayer.height / 2);
			_arrowLayer.graphics.lineTo(GAP + ARROW_WIDTH + ARROW_OFFSET, _labelLayer.height - GAP);
			_arrowLayer.graphics.lineTo(GAP + ARROW_OFFSET, _labelLayer.height - GAP);
			_arrowLayer.graphics.lineTo(GAP, _labelLayer.height / 2);
			_arrowLayer.graphics.endFill();
			_arrowLayer.graphics.beginFill(_arrowColour);
			_arrowLayer.graphics.moveTo(_attributes.widthH - GAP,_labelLayer.height / 2);
			_arrowLayer.graphics.lineTo(_attributes.widthH - ARROW_OFFSET - GAP, GAP);
			_arrowLayer.graphics.lineTo(_attributes.widthH - ARROW_WIDTH - ARROW_OFFSET - GAP, GAP);
			_arrowLayer.graphics.lineTo(_attributes.widthH - ARROW_OFFSET - GAP, _labelLayer.height / 2);
			_arrowLayer.graphics.lineTo(_attributes.widthH - ARROW_WIDTH - ARROW_OFFSET - GAP, _labelLayer.height - GAP);
			_arrowLayer.graphics.lineTo(_attributes.widthH - ARROW_OFFSET - GAP, _labelLayer.height - GAP);
			_arrowLayer.graphics.lineTo(_attributes.widthH - GAP, _labelLayer.height / 2);
			_arrowLayer.graphics.endFill();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, _attributes.widthH, _labelLayer.height);
			_labelLayer.x = _midPoint = (_attributes.widthH - _labelLayer.width) / 2;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			applyMask();
		}
		
		
		protected function mouseDown(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_lastX = mouseX;
			_distance = 0;
			_timer.reset();
			_timer.start();
			_arrowLayer.alpha = 1.0;
		}
		
		
		protected function mouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_timer.stop();
			_arrowLayer.alpha = ALPHA;
			if (!_slideInTimer.running && !_slideOutTimer.running) {
				_labelLayer.x = _midPoint;
			}
		}
		
		
		protected function mouseMove(event:TimerEvent):void {
			if (!_slideInTimer.running && !_slideOutTimer.running) {
				var difference:Number = mouseX - _lastX;
				if (difference * _distance < 0) {
					_distance = 0;
				}
				if (mouseX > _attributes.width - SENSOR) {
					_distance += SCROLL_INCREMENT;
				}
				else if (mouseX < SENSOR) {
					_distance -= SCROLL_INCREMENT;
				}
				else {
					_distance += difference;
				}
				_labelLayer.x = _midPoint + _distance;
				if (_distance > SCROLL_INCREMENT) {
					_distance = _distance - SCROLL_INCREMENT;
					animateTransition(true);
				}
				else if (_distance < -SCROLL_INCREMENT) {
					_distance = _distance + SCROLL_INCREMENT;
					animateTransition(false);
				}
			}
			_lastX = mouseX;
		}
		
		
		public function set text(value:String):void {
			if (_font) {
				_labelLayer.htmlText = _font.toXMLString() + value;
			}
			else {
				_labelLayer.text = value;
			}
			_labelLayer.x = _midPoint = (_attributes.widthH - _labelLayer.width) / 2;
		}
		
		
		public function set data(value:Array):void {
			_data = new <String>[];
			for each (var item:String in value) {
				_data.push(item);
			}
			text = _data.length > 0 ? _data[0] : "";
		}
		
		
		public function set xmlData(value:XML):void {
			_data = new <String>[];
			for each (var item:XML in value.children()) {
				_data.push((item.@label.length() > 0) ? item.@label : item.localName());
			}
			text = _data.length > 0 ? _data[0] : "";	
		}
		
		
		override public function destructor():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_timer.removeEventListener(TimerEvent.TIMER, mouseMove);
			_slideOutTimer.removeEventListener(TimerEvent.TIMER, moveLabel);
			_slideOutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, slideOutComplete);
			_slideInTimer.removeEventListener(TimerEvent.TIMER, moveLabel);
		
		}
	}
}
