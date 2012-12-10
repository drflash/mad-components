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

package com.powerflasher.SampleApp {
	
	[SWF(frameRate="60", backgroundColor="#FFFFFF")]

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;	
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.stage3Dacceleration.*;

	public class ListScrollingTest extends Sprite {

			
		protected static const DATA:XML =
				
					<data>
						<Red/>
						<Orange/>
						<Yellow/>														
						<Green/>
						<Blue/>
						<Indigo/>
						<Pink/>
						<Tangerine/>
						<Purple/>
						<Orange/>
						<Yellow/>														
						<Green/>
						<Blue/>
						<Indigo/>
						<Pink/>
						<Tangerine/>
						<Purple/>
						<Orange/>
						<Yellow/>														
						<Green/>
						<Blue/>
						<Indigo/>
						<Pink/>
						<Tangerine/>
						<Purple/>
						<Red/>
						<Orange/>
						<Yellow/>														
						<Green/>
						<Blue/>
						<Indigo/>
						<Pink/>
						<Tangerine/>
						<Purple/>
					</data>;
	
			
		protected static const LAYOUT:XML = 
		
			<list id="list" background="#CCCCFF,#CCCCFF">
				{DATA}
				<horizontal>
					<label id="label"/>;
					<switch id="switch" alignH="right"/>
				</horizontal>
			</list>;
	
	
	
		protected var _list:UIList;
		protected var _listScrolling:LongListScrolling;


		public function ListScrollingTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, LAYOUT);

			_list = UIList(UI.findViewById("list"));
            _list.addEventListener(UIList.CLICKED, clickHandler);
			_list.addEventListener(UIList.LONG_CLICK, longClickHandler);
			_list.addEventListener(UIList.CLICKED_END, clickedEndHandler);
			
			
			for (var i:int = 0; i < _list.length; i++) {
				UISwitch(_list.findViewById("switch", i)).addEventListener(Event.CHANGE, switchChanged);
			}
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}


		protected function contextComplete(event:Event):void {
			_listScrolling = new LongListScrolling();
			_listScrolling.allListTextures();
        }
		
		
		protected function clickHandler(event:Event):void {
        	trace("clicked:"+_list.index);
		}
		
		
		protected function longClickHandler(event:Event):void {
        	trace("long clicked");
		}
		
		
		protected function clickedEndHandler(event:Event):void {
        	trace("clicked end");
		}
		
		
		protected function switchChanged(event:Event):void {
			trace("switch changed:"+_listScrolling.componentChanged.name);
			_listScrolling.updateClickedComponent();
        }

	}
}
