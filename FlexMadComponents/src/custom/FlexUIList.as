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

package custom {
	
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.stage3Dacceleration.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	
	import spark.core.SpriteVisualElement;

	
	public class FlexUIList extends FlexUIForm
	{
		protected var _gpu:Boolean = false;
		protected var _listAcceleration:LongListScrollingE;
		
		public function FlexUIList() {
			_xml = <list/>;
		}
		
		
		override protected function createComponent(width:Number, height:Number):void {
			_attributes = new Attributes(0, 0, width, height);
			_attributes.parse(_xml);
			_component = new UIList(this, _xml, _attributes);
			_component.x = _gap;
			_component.y = _gap;
			if (_gpu) {
				this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			}
		}
		
		
		protected function addedToStageHandler(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			FlexGlobals.topLevelApplication.addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(Sprite(FlexGlobals.topLevelApplication));
		}
		
		
		protected function contextComplete(event:Event):void {
			_listAcceleration = new LongListScrollingE();
			_listAcceleration.listTextures(new <IContainerUI>[IContainerUI(_component)]);
		}
		
		
		override protected function resizeComponent(width:Number, height:Number):void {
			_attributes.width = width;
			_attributes.height = height;
			UIList(_component).layout(_attributes);
		}
		
		
		public function set dataXML(value:XML):void {
			_xml = <list>{value}</list>;
		}
		
		
		public function set gpu(value:Boolean):void {
			_gpu = value;
		}

	}
}