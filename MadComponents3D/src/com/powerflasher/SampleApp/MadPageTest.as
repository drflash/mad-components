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
	import flash.utils.getQualifiedClassName;

	public class MadPageTest extends Sprite {
		
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
		
		protected static const PAGE0:XML = 
		<vertical background="#CCCCCC,#BBBBBB,4">
		<label>{WHITE}Picker</label>
		<line/>
		<columns widths="5%,90&%,5%">
		<image/>
			<columns alignV="centre" gapH="0" id="columns0" >
					<picker id="picker0" background="#FFFFCC">{FRUIT_DATA}</picker>
					<picker id="picker1">{FRUIT_DATA}</picker>
					<picker id="picker2">{FRUIT_DATA}</picker>												
				</columns>
				<image/>
			</columns>
		</vertical>;

			
		protected static const PAGE1:XML =
		
			<vertical background="#666666,#333333">
			<label>{WHITE}Components</label>
			<line/>
				<columns id="columns1">
					<vertical>
						<input alignH="fill" prompt="input:"/>
						<horizontal>
							<vertical>
								<checkBox/>
								<checkBox/>
							</vertical>
							<vertical>
								<switch alignH="fill" background="#FF8000">YES,NO</switch>
								<button alignH="fill">button</button>
							</vertical>
						</horizontal>
						<slider id="slider" background="#FF9966"/>
						<progressBar id="progressBar"/>
					</vertical>
					<vertical alignH="fill">
						<switch alt="true" alignH="right"/>
						<segmentedControl background="#CCCCCC,#336633"><data><one/><two/></data></segmentedControl>
						<radioButton>{WHITE}radio button</radioButton>
						<radioButton>{WHITE}radio button</radioButton>
						<popUpButton id="popupButton" value="pop up ..."/>
					</vertical>
				</columns>
			</vertical>;
			
			
		protected static const PAGE2:XML = <dividedList id="list" colour="#666677" background="#EEEEFF,#FFFFFF,#EEEEFF" headingTextColour="#EEEEFF" headingShadowColour="#333344" mask="true">												
												<horizontal>
													<image id="image">48</image>
													<vertical>
														<label id="label"><font size="18"/></label>
														<label id="label2"><font color="#666666" size="11"/></label>
													</vertical>
												</horizontal>
											</dividedList>;
											
											
		protected static const MATRIX:XML =
		
				<data>
					<row>1,2,3,4</row>
					<row>3,8,4,1</row>
					<row>4,1,5,12</row>
				</data>;

		protected static const NUMBERS:XML = <data>3,5,4,2,1</data>;
		
		protected static const COLOURS:XML = <colours>#99FF99,#CC9999,#9999CC,#CCCC66,#CC9966</colours>;
		
			
		protected static const PAGE3:XML =	

			<vertical background="#CCCC99,#CCCCCC,6">
				<label>{WHITE}Charts</label>
				<line/>	
				<columns>	
					<pieChart alignV="centre">{COLOURS}{NUMBERS}</pieChart>;
					<barChart alignV="centre" render="2d" stack="true" order="rows" palette="subtle">{MATRIX}</barChart>
				</columns>
			</vertical>;

			
		protected static const LAYOUT:XML =
		
			<navigation id="pages" alt="true" colour="#334433" background="#FFCCFF" rightButton="MadPages">
				{PAGE0}
				{PAGE1}
				{PAGE2}
				{PAGE3}
			</navigation>;
			
		protected var _pages:UINavigation;
		protected var _list:UIDividedList;
		protected var _columns0:UIForm;
		protected var _columns1:UIForm;

		protected var _pageFlipping:PageFlippingE;
		protected var _listScrolling:LongListScrollingE;
		
		
		public function MadPageTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, LAYOUT);
			
			_pages = UINavigation(UI.findViewById("pages"));
			_pages.navigationBar.rightButton.addEventListener(UIButton.CLICKED, pageFlipping);
			_pages.autoForward = false;
			
			//Populate the first list
			var data:Array = [];
			for (var i:int=0; i<WORDS.length; i++) {
				data.push({label:WORDS[i], image:getQualifiedClassName(PICTURES[i%PICTURES.length]), label2:'here is some small text'});
			}
			_list = UIDividedList(UI.findViewById("list"));
			var groupedData:Array = [];
			for (var j:int = 0; j<5; j++)
				groupedData.push("MadComponents is ...", data);
			_list.data = groupedData;

			_columns0 = UIForm(UI.findViewById("columns0"));
			_columns1 = UIForm(UI.findViewById("columns1"));
			addEventListener(PageFlipping.FINISHED, pageFlippingFinished);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}


		protected function contextComplete(event:Event):void {
			_pageFlipping = new PageFlippingE();
			_pageFlipping.containerPageTextures(_pages);
			_listScrolling = new LongListScrollingE();
			_listScrolling.allListTextures();
		}


		protected function pageFlipping(event:Event):void {
			_listScrolling.freezeLists();
			if (_pages.pageNumber < 3) {
				_pageFlipping.updatePage(_pages.pageNumber, [_columns0, _columns1, _list][_pages.pageNumber]);
			}
			_pageFlipping.zoomOutToMadPages(true);
		}

				
		protected function pageFlippingFinished(event:Event):void {
		}
	}
}
