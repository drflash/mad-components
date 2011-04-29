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
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;

	
	public class MadComponents extends Sprite {
		
		protected static const FRUIT_DATA:XML = <data>
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
		
		protected static const DATA:XML = <data>
											<Red/>
											<Orange/>
											<Yellow/>
											<Green/>
											<Blue/>
											<Indigo/>
										 </data>;

		protected static const COLUMNS:XML = <columns alignH="fill">
												<button>one</button><button>two</button><button>three</button>
											</columns>;
		
		protected static const LAYOUT0:XML = <vertical>
												<frame colour="#993333">{COLUMNS}</frame>
												<frame colour="#339933">{COLUMNS}</frame>
												<frame colour="#333399">{COLUMNS}</frame>
												<image/>
												<button id="popup" alignH="centre">show pop-up</button>
											</vertical>;
		
		protected static const LAYOUT1:XML = <vertical background="#EEEEEE,#FFFFFF" colour="#99CC99">
												<button alignH="fill" colour="#00ff00">a button</button>
												<horizontal><button>hello</button><input alignH="fill" background="#7777AA,#555588"/></horizontal>
												<horizontal><label id="label0">hello world</label><button colour="#ff9000">hi</button>
													<vertical colour="#0000ff"><button alignH="fill">vertical1</button><button>vertical2</button></vertical>
												</horizontal>
												<horizontal>
													<switch colour="#999999"/><switch colour="#FF8000">YES,NO</switch><image id="image0" alignH="right">48</image>
												</horizontal>
											</vertical>;
		
		protected static const LIST0:XML = <list id="list0" colour="#FFFFFF" background="#CCCCCC,#FFFFFF">
												<horizontal><image id="image">48</image><vertical><label id="label"/><label id="label2"/></vertical></horizontal>
											</list>;
		
		protected static const LIST1:XML = <list id="list1" gapV="16" background="#EEFFEE,#778877" colour="#000000">
												<horizontal><label id="label"/><arrow colour="#FFDDCC" alignH="right"/></horizontal>								
											</list>;
		
		protected static const LIST2:XML = <list id="list2" background="#BBBBFF,#BBBBFF,#CCCCFF" colour="#BBBBFF">
												{FRUIT_DATA}
												<font color="#333366"/>											
											</list>;
		
		protected static const LIST_GROUPS:XML = <groupedList id="list4" background="#333333,#FF9999,#FF9966,#FFFF99,#99FF99,#9999FF" gapH="64" gapV="10"/>;
		
		protected static const TICK_LIST:XML = <tickOneList gapV="6" id="tickList" colour="#333333" background="#EEEEEE">{FRUIT_DATA}</tickOneList>;
		
		protected static const DATA_GRID:XML = <dataGrid colour="#999999" background="#888899,#EEEEFF,#DDDDEE">
												<widths>30,30,40</widths>
												<header>one,two,three</header>
												<data>	
													<row>1,2,3</row>
													<row>4,5,6</row>
													<row>7,8,9</row>
													<row>2,7,5</row>
													<row>1,2,3</row>
													<row>4,5,6</row>
													<row>7,8,9</row>
													<row>2,7,5</row>
												</data>
											</dataGrid>;
		
		protected static const FLIPPER:XML = <viewFlipper background="#CCCC00,#CCCC33" scrollBarColour="#FFFFFF">{LAYOUT0}{LAYOUT1}{DATA_GRID}</viewFlipper>;

		protected static const LIST_GROUPS_RENDERER:XML = <groupedList id="list3" background="#C6CCD6,#FFFFFF" colour="#CCCC66" gapH="32" gapV="4">
															<horizontal><label id="label"/><switch id="switch" colour="#996600" alignH="right"/></horizontal>
														</groupedList>;
		
		protected static const NAVIGATOR:XML = <navigation background="#FFFFFF" id="navigator">{LIST0}{LIST1}{LIST2}{LIST_GROUPS_RENDERER}{TICK_LIST}</navigation>;
		
		protected static const TAB_NAVIGATOR:XML = <tabPages id="tabPages" background="#333366,#333333" colour="#111122">{NAVIGATOR}{FLIPPER}</tabPages>;
		
		protected static const POPUP_WINDOW:XML = <vertical alignH="fill">
													<columns gapH="0">
														<picker id="picker1" background="#FFFFFF">
															{DATA}
														</picker>
														<picker id="picker1" background="#FFFFFF">
															{DATA}
														</picker>
													</columns>
													<columns>
														<button colour="#669966" id="cancel">cancel</button>
														<button colour="#996666" id="ok">ok</button>
													</columns>
												</vertical>;

		protected static const FONT:String = '<font size="20">';
		protected static const END_FONT:String = "</font>";
		
		
		[Embed(source="images/mp3_48.png")]
		protected static const MP3:Class;
		
		[Embed(source="images/MP4_48.png")]
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
		
		[Embed(source="images/list_highlight.png")]
		protected static const LIST_ICON_HIGHLIGHT:Class;
		
		[Embed(source="images/views_highlight.png")]
		protected static const VIEWS_ICON_HIGHLIGHT:Class;
		
		protected static const PICTURES:Vector.<Class> = new <Class>[MP3, MP4, PALM, PSP, USB];
		protected static const FRUIT:Vector.<String> = new <String>["Apple","Orange","Banana","Pineapple","Lemon","Mango","Plum","Cherry","Lime","Peach","Pomegranate","Grapefruit","Strawberry","Melon"];
		
		protected var _popUp:UIWindow;
		
		
		public function MadComponents(screen:Sprite = null) {
			var i:int;
			
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, TAB_NAVIGATOR);

			//Set up the tab buttons
			var uiTabPages:UITabPages = UITabPages(UI.findViewById("tabPages"));
			uiTabPages.setTab(0, "lists", LIST_ICON, LIST_ICON_HIGHLIGHT);
			uiTabPages.setTab(1,"view flipper", VIEWS_ICON, VIEWS_ICON_HIGHLIGHT);
			
			//Populate the first list
			var data0:Array = [];
			for (i=0; i<FRUIT.length; i++) {
				data0.push({label:'<font size="18">'+FRUIT[i]+'</font>', image:getQualifiedClassName(PICTURES[i%PICTURES.length]), label2:'<font color="#666666" size="11">here is some small text</font>'});
			}
			var uiList1:UIList = UIList(UI.findViewById("list0"));
			uiList1.data = data0;
			
			//Populate the second list
			var data1:Array = [];
			for (i=0; i<FRUIT.length; i++) {
				data1.push({label:'<font color="#FFDDCC">'+FRUIT[i]+'</font>'});
			}
			var uiList:UIList = UIList(UI.findViewById("list1"));
			uiList.data = data1;
			
			//Populate the grouped list
			var uiGroupedList:UIGroupedList = UIGroupedList(UI.findViewById("list3"));
			uiGroupedList.data = [[{label:FONT+"zero"+END_FONT}],[{label:FONT+"one"+END_FONT},{label:FONT+"two"+END_FONT},{label:FONT+"three"+END_FONT}],[{label:FONT+"four"+END_FONT},{label:FONT+"five"+END_FONT},{label:FONT+"six"+END_FONT}],[{label:FONT+"seven"+END_FONT},{label:FONT+"eight"+END_FONT},{label:FONT+"nine"+END_FONT},{label:FONT+"ten"+END_FONT}]];
			
			//Set up an images
			var image0:UIImage = UIImage(UI.findViewById("image0"));
			image0.imageClass = PALM;
			
			//Write to a text label
			var label0:UILabel = UILabel(UI.findViewById("label0"));
			label0.defaultTextFormat = new TextFormat("Arial",14,0xFFFFFF);
			label0.text = "White text";
			
			//Set up navigation title
			var navigator:UINavigation = UINavigation(UI.findViewById("navigator"));
			navigator.text = "lists";
			
			//Set up a pop-up window
			_popUp = UI.createPopUp(POPUP_WINDOW,180.0,200.0);
			UI.hidePopUp(_popUp);
			
			var showPopUpButton:UIButton = UIButton(UI.findViewById("popup"));
			showPopUpButton.addEventListener(UIButton.CLICKED,showPopUp);
			
			var hidePopUpButton:UIButton = UIButton(_popUp.findViewById("ok"));
			hidePopUpButton.addEventListener(UIButton.CLICKED,hidePopUp);
			
			var cancelPopUpButton:UIButton = UIButton(_popUp.findViewById("cancel"));
			cancelPopUpButton.addEventListener(UIButton.CLICKED,hidePopUp);
		}
		
		
		protected function showPopUp(event:Event):void {
			UI.showPopUp(_popUp);
		}
		
		
		protected function hidePopUp(event:Event):void {
			UI.hidePopUp(_popUp);
		}

	}
}