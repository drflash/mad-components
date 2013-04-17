package com.danielfreeman.extendedMadness
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;

/**
 *  MadComponents icons component
 * <pre>
 * &lt;icons
 *    id = "IDENTIFIER"
 *    highlightColour = "#rrggbb"
 *    iconColour = "#rrggbb"
 *    background = "#rrggbb, #rrggbb, …"
 *    gapV = "NUMBER"
 *    gapH = "NUMBER"
 *    alignH = "left|right|centre|fill"
 *    alignV = "top|bottom|centre|fill"
 *    visible = "true|false"
 *    border = "true|false"
 *    leftMargin = "NUMBER"
 * /&gt;
 * </pre>
 */	
	public class UIIcons extends UIContainerBaseClass {

		protected var _icons:Vector.<DisplayObject>;
		protected var _timer:Timer = new Timer(50,1);
		protected var _index:int = -1;
		protected var _pressIndex:int = -1;
		protected var _iconColour:uint = uint.MAX_VALUE;
		protected var _highlightColour:uint = UIList.HIGHLIGHT;
		protected var _leftMargin:Number = 0;
		
		
		public function UIIcons(screen:Sprite, xml:XML, attributes:Attributes) {
			
			if (xml.@highlightColour.length() > 0) {
				_highlightColour = UI.toColourValue(xml.@highlightColour);
			}
			if (xml.@iconColour.length() > 0) {
				_iconColour = UI.toColourValue(xml.@iconColour);
			}
			if (xml.@leftMargin.length() > 0) {
				_leftMargin = parseFloat(xml.@leftMargin);
			}
			super(screen, xml, attributes);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_timer.addEventListener(TimerEvent.TIMER, unHighlight);
			text = xml.toString().replace(/[\s\r\n\t]/g,"");
			unHighlight();
		}
		
		
		protected function mouseDown(event:MouseEvent):void {
			_pressIndex = -1;
			for (var i:int = 0; i < _icons.length; i++) {
				var icon:DisplayObject = _icons[i];
				if (mouseX < icon.x + icon.width + _attributes.paddingH/2) {
					_pressIndex = i;
					highlight();
					break;
				}
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);					
		}
		
		
		protected function mouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			var index:int = -1;
			for (var i:int = 0; i < _icons.length; i++) {
				var icon:DisplayObject = _icons[i];
				if (mouseX < icon.x + icon.width + _attributes.paddingH/2) {
					index = i;
					break;
				}
			}
			if (_pressIndex == index) {
				_index = _pressIndex;
				dispatchEvent(new Event(Event.CHANGE));
			}
			_timer.reset();
			_timer.start();
			_pressIndex = -1;
		}
		
		
		protected function highlight():void {
			var colour:ColorTransform = new ColorTransform();
			colour.color = _highlightColour;
			DisplayObject(_icons[_pressIndex]).transform.colorTransform = colour;
		}
		
		
		protected function unHighlight(event:TimerEvent = null):void {
			for each (var icon:DisplayObject in _icons) {
				var colour:ColorTransform = new ColorTransform();
				if (_iconColour < uint.MAX_VALUE) {
					colour.color = _iconColour;
				}
				icon.transform.colorTransform = colour;
			}
		}
		
		
		public function get index():int {
			return _index;
		}
		
		
		public function set index(value:int):void {
			_index = value;
			highlight();
			_timer.reset();
			_timer.start();
		}
		
		
		override public function drawComponent():void {
			graphics.clear();
			graphics.beginFill(0, 0);
			graphics.drawRect(0, 0, width + _attributes.paddingH, height);
		}
		
		
		public function set text(source:String):void {
			var position:Number = _leftMargin;
			var dimensions:Array = source.split(",");
			if (_icons)
				clear();
			_icons = new <DisplayObject>[];
			for (var i:int = 0; i < dimensions.length; i++) {
				var icon:DisplayObject = DisplayObject(new (getDefinitionByName(dimensions[i]) as Class));
				_icons.push(icon);
				if (icon is Bitmap) {
					Bitmap(icon).smoothing = true;
				}
				addChild(icon);
				icon.x = position;
				position += icon.width + _attributes.paddingH;
			}
			drawComponent();
		}
		
		
		override public function clear():void {
			for each (var icon:DisplayObject in _icons) {
				removeChild(icon);
			}
			graphics.clear();
			_icons = null;
		}
		
		
		public function set icons(value:Vector.<DisplayObject>):void {
			if (_icons)
				clear();
			_icons = value;
		}
	
	
		override public function destructor():void {
			removeEventListener(MouseEvent.MOUSE_UP, mouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_timer.removeEventListener(TimerEvent.TIMER, unHighlight);
		}
	}
}
