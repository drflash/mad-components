package com.danielfreeman.extendedMadness {

	import com.danielfreeman.madcomponents.*;

	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;

/**
 * Screen has changed
 */
		[Event( name="screenChanged", type="flash.events.Event" )]
		
		
	public class UIScreens extends UIPages {
		
		public static const SCREEN_CHANGED:String = "screenChanged";
		
		public function UIScreens(screen : Sprite, xml : XML, attributes : Attributes) {
			super(screen, xml, attributes);
		}
	
	
		protected function useThisOne(option:String):Boolean {
			var result:Boolean = true;
			if (option.substr(0,1) == "L") {
				result = UI.attributes.width >= UI.attributes.height;
				option = option.substr(1);
			}
			else if (option.substr(0,1) == "R") {
				result = UI.attributes.width <= UI.attributes.height;
				option = option.substr(1);
			}
			var size:int = parseInt(option);
			if (!isNaN(size)) {
				result = result && (UI.attributes.width <= size);
			}
			return result;
		}
		
		
		protected function whichScreenIndex():int {
			var index:int = 0;
			for each(var child:XML in _xml.children()) {
				if (useThisOne(child.@option)) {
					return index;
				}
				index++;
			}
			return _xml.children().length() - 1;
		}
		
		
		override protected function setInitialPage():void {
			if (_pages.length>0) {
				var index:int = whichScreenIndex();
				_thisPage = _pages[index];
				_page = index;
				_thisPage.visible = true;
			}
		}
		
/**
 *  Search for component by id
 */
		override public function findViewById(id:String, row:int = -1, group:int = -1):DisplayObject {
			for each (var view:DisplayObject in _pages) {
				if (view.name == id) {
					return view;
				}
			}
			return IContainerUI(_thisPage).findViewById(id, row, group);
		}
				
/**
 *  Rearrange the layout to new screen dimensions
 */	
		override public function layout(attributes:Attributes):void {
			var newPageIndex:int = whichScreenIndex();
			if (_page != newPageIndex) {
				_thisPage.visible = false;
				_thisPage = _pages[newPageIndex];
				_thisPage.visible = true;
				_page = newPageIndex;
				dispatchEvent(new Event(SCREEN_CHANGED));
			}
			super.layout(attributes);
		}
	}
}
