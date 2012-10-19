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
	

	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIGroupedList;
	import com.danielfreeman.madcomponents.UIList;
	import com.danielfreeman.stage3Dacceleration.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class RecycleListScrollingTest extends Sprite {
		

		[Embed(source="images/mp3_48.png")]
		protected static const MP3:Class;
		
		[Embed(source="images/mp4_48.png")]
		protected static const MP4:Class;

		[Embed(source="images/palm_48.png")]
		protected static const PALM:Class;
		
		[Embed(source="images/psp_48.png")]
		protected static const PSP:Class;
		
		[Embed(source="images/usb_48.png")]
		protected static const USB:Class;
		
		protected static const PICTURES:Vector.<Class> = new <Class>[MP3, MP4, PALM, PSP, USB];
		protected static const WORDS:Vector.<String> = new <String>["Open Source","Popular","Lightweight","Versatile","Styleable","Skinnable","Powerful","Easily Extensible","Stage3D Accelerated"];

				
		protected static const LAYOUT:XML = 
		
			<dividedList lazyRender="true" recycle="true" id="list" gapV="4" background="#DDDDFF,#FFFFFF">
				<horizontal>
					<image id="image">48</image>
					<vertical>
						<label id="label"><font size="18"/></label>
						<label id="label2"><font color="#666666" size="11"/></label>
					</vertical>
				</horizontal>														
			</dividedList>;
	
	
	
		protected var _list:UIGroupedList;
		protected var _listScrolling:ListScrolling;
		protected var _pageFlipping:PageFlipping;

		public function RecycleListScrollingTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UI.create(this, LAYOUT);

			_list = UIGroupedList(UI.findViewById("list"));
            _list.addEventListener(UIList.CLICKED, clickHandler);
			_list.addEventListener(UIList.LONG_CLICK, longClickHandler);
			_list.addEventListener(UIList.CLICKED_END, clickedEndHandler);
			
			var data:Array = [];
			for (var i:int=0; i<WORDS.length; i++) {
				data.push({label:WORDS[i], image:getQualifiedClassName(PICTURES[i%PICTURES.length]), label2:'here is some small text'});
			}
			_list = UIGroupedList(UI.findViewById("list"));
			var groupedData:Array = [];
			for (var j:int = 0; j<20; j++) {
				groupedData.push("MadComponents is ...", data);
			}
			_list.data = groupedData;

			trace("list length="+Sprite(_list.pages[0]).height);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}


		protected function contextComplete(event:Event):void {
			_listScrolling = new LongListScrolling();
			_listScrolling.allListTextures();
        }
		
		
		protected function clickHandler(event:Event):void {
        	trace("clicked");
		}
		
		
		protected function longClickHandler(event:Event):void {
        	trace("long clicked");
		}
		
		
		protected function clickedEndHandler(event:Event):void {
        	trace("clicked end");
		}

	}
}
