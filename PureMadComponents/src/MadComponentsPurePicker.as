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


package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import com.danielfreeman.madcomponents.*;
	import flash.events.Event;
	
	
	public class MadComponentsPurePicker extends Sprite {
		
		protected var _picker0:UIPicker;
		protected var _picker1:UIPicker;
		
		protected static const DATA:XML = <data>
											<Apple/>
											<Orange/>
											<Banana/>
											<Pineapple/>
											<Lemon/>
											<Mango/>
											<Plum/>
											<Cherry/>
											<Lime/>
											<Peach/>
											<Pomegranate/>
											<Grapefruit/>
											<Strawberry/>
											<Melon/>
										</data>;
		
		
		public function MadComponentsPurePicker(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var columns:UIForm = new UIForm(this, <columns gapH="0"><picker id="picker0">{DATA}</picker><picker id="picker1">{DATA}</picker></columns>,new Attributes(0,0,280,200));
			columns.x = 20;
			columns.y = 40;
			
			_picker0 = UIPicker(columns.findViewById("picker0"));
			_picker0.addEventListener(Event.CHANGE, picker0Changed);
			
			_picker1 = UIPicker(columns.findViewById("picker1"));
			_picker1.addEventListener(Event.CHANGE, picker1Changed);
		}
		
		
		protected function picker0Changed(event:Event):void {
			trace("Picker0:"+_picker0.index+","+_picker0.row.label);
		}
		
		
		protected function picker1Changed(event:Event):void {
			trace("Picker1:"+_picker1.index+","+_picker1.row.label);
		}
	}
}