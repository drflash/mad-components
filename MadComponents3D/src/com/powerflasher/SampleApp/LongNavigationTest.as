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
	import flash.events.MouseEvent;
	
	[SWF(frameRate="60", backgroundColor="#FFFFFF")]	
	

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;	
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.stage3Dacceleration.*;
	import flash.utils.getQualifiedClassName;

	public class LongNavigationTest extends Sprite {
		
		[Embed(source="images/options.png")]
		protected static const OPTIONS:Class;
		
		[Embed(source="images/zoomin.png")]
		protected static const ZOOMIN:Class;
		
		[Embed(source="images/arrow.png")]
		protected static const ARROW:Class;
		
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
		
		[Embed(source="images/list.png")]
		protected static const LIST_ICON:Class;
		
		[Embed(source="images/views.png")]
		protected static const VIEWS_ICON:Class;
		
		protected static const WHITE:XML = <font color="#FFFFFF"/>;
		protected static const BIG_WHITE:XML = <font size="100" color="#FFFFFF"/>;
		
		protected static const PICTURES:Vector.<Class> = new <Class>[MP3, MP4, PALM, PSP, USB];
		protected static const WORDS:Vector.<String> = new <String>["Open Source","Popular","Lightweight","Versatile","Styleable","Skinnable","Powerful","Easily Extensible","Stage3D Accelerated"];
		
		protected static const FRUIT_DATA:XML = <data>
											<Apple/>
											<Orange/>
											<Banana/>
											<Lemon/>
											<Mango/>
											<Plum/>
											<Cherry/>
											<Lime/>
											<Peach/>
											<Melon/>
										</data>;
			
			
		protected static const MATRIX:XML = <data>
			<row>1,2,3,4</row>
			<row>3,8,4,1</row>
			<row>4,1,5,12</row>
		</data>;

			
		protected static const LIST:XML = <dividedList id="list" colour="#666677" background="#EEEEFF,#FFFFFF,#EEEEFF" headingTextColour="#EEEEFF" headingShadowColour="#333344">												
												<horizontal>
													<image id="image">48</image>
													<vertical>
														<label id="label"><font size="18"/></label>
														<label id="label2"><font color="#666666" size="11"/></label>
													</vertical>
												</horizontal>
											</dividedList>;


		protected static const NUMBERS:XML = <data>3,5,4,2,1</data>;
		
		protected static const COLOURS:XML = <colours>#99FF99,#CC9999,#9999CC,#CCCC66,#CC9966</colours>;
		
			
		protected static const PAGE:XML =	

			<vertical background="#CCCC99,#CCCCCC,6">
				<label>{WHITE}Charts</label>
				<line/>	
				<columns>	
					<pieChart alignV="centre">{COLOURS}{NUMBERS}</pieChart>;
					<barChart alignV="centre" render="2d" stack="true" order="rows" palette="subtle">{MATRIX}</barChart>
				</columns>
			</vertical>;

			
		protected static const LAYOUT:XML =
		
			<navigation title="Navigation Test" id="pages" colour="#334433">
				{LIST}
				{PAGE}
			</navigation>;		

			
		protected var _pages:UINavigation;
		protected var _list:UIDividedList;
		
		protected var _listScrolling:LongListScrollingE;


		public function LongNavigationTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, LAYOUT);
			
			_pages = UINavigation(UI.findViewById("pages"));
			_pages.autoForward = false;
			_pages.autoBack = false;
			_pages.navigationBar.backButton.addEventListener(MouseEvent.MOUSE_UP, goBack);
			
			//Populate the first list
			var data:Array = [];
			for (var i:int=0; i<WORDS.length; i++) {
				data.push({label:WORDS[i], image:getQualifiedClassName(PICTURES[i%PICTURES.length]), label2:'here is some small text'});
			}
			_list = UIDividedList(UI.findViewById("list"));
			_list.data = ["MadComponents is ...", data, "MadComponents is ...", data];
			_list.addEventListener(UIList.CLICKED_END, doSlide);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
			
		}


		protected function contextComplete(event:Event):void {
			_listScrolling = new LongListScrollingE();
			_listScrolling.containerPageTextures(_pages);
		}


		protected function doSlide(event:Event):void {
			_listScrolling.slidePage(0, 1);
		}
		
				
		protected function goBack(event:Event):void {
			_listScrolling.slidePage(1, 0, true);
			
		}
	}
}
