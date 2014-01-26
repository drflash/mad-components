package com.danielfreeman.extendedMadness
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;


	public class UILabelShadow extends UIContainerBaseClass {
		
		protected static const SHADOW_COLOUR:uint = 0x000000;

		protected var _label:UILabel;
		protected var _shadow:UILabel;
		protected var _text:String;
		protected var _shadowColour:uint = SHADOW_COLOUR;

		public function UILabelShadow(screen:Sprite, xml:XML, attributes:Attributes) {			
			_shadow = new UILabel(this, 1, 1, xml.toXMLString());
			_label = new UILabel(this, 0, 0, xml.toXMLString());
			text = xml;
			
			if (xml.@height.length() > 0) {
				_label.fixheight = _shadow.fixheight = Number(xml.@height);
			}
			if (xml.@autosize.length() > 0 && xml.@autosize != "false") {
				_label.autoSize = _shadow.autoSize = TextFieldAutoSize.LEFT;
			}
			if (xml.@background.length() > 0) {
				_label.background = true;
				_label.backgroundColor = UI.toColourValue(xml.@background);
				removeChild(_shadow);_shadow = null;
			}
			super(screen, xml, attributes);
		}
		
		
		override public function drawComponent():void {
			if (attributes.fillH || xml.@height.length()>0) {
				_label.fixwidth = _attributes.widthH;
				if (_shadow) {
					_shadow.fixwidth = _attributes.widthH;
				}
				var textAlign:String = attributes.textAlign;
				if (textAlign != "") {
					var format:TextFormat = new TextFormat();
					format.align = textAlign;
					_label.defaultTextFormat = format;
					if (_shadow) {
						_shadow.defaultTextFormat = format;
					}
				}
			}
		}
		
		
		public function set text(value:String):void {
			if (value=="") {
				value = " ";
			}
			if (XML('<t>' + value + '</t>').hasComplexContent()) {
				_label.htmlText = value;
				if (_shadow) {
					_shadow.htmlText = value;
				}
				_text = _label.text;
			} else {
				_text = _label.text = value;
				if (_shadow) {
					_shadow.text = value;
				}
			}
			if (_shadow) {
				_shadow.setTextFormat(new TextFormat(null, null, _shadowColour));
			}
		}
		
		
		public function shorten(width:Number, elipses:String = ".."):void {
			if (_label.width > width) {
				var position:int = _label.getCharIndexAtPoint(width, 4);
				var text:String = _text.substr(0, position - 1) + elipses;
				_label.text = _shadow.text = text;
				if (_shadow) {
					_shadow.setTextFormat(new TextFormat(null, null, _shadowColour));
				}
			}
		}
	}
}