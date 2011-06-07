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
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
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
											<Violet/>
										 </data>;
		
		protected static const GROUPED_DATA:XML = <data>
													<group label="one">
														<Red/>
														<Orange/>
														<Yellow/>														
													</group>
													<group label="two">
														<Green/>
														<Blue/>
														<Indigo/>
													</group>
													<group label="three">
														<Pink/>
														<Tangerine/>
														<Purple/>
													</group>
												</data>;
		
		protected static const COLUMNS:XML = <columns alignH="fill">
												<button>one</button>
												<button>two</button>
												<button>three</button>
											</columns>
		
		protected static const LAYOUT0:XML = <vertical>
												<label id="player"><font color="#FFFFFF"/></label>
												<frame colour="#993333">{COLUMNS}</frame>
												<frame colour="#339933">{COLUMNS}</frame>
												<frame colour="#333399">{COLUMNS}</frame>
												<image/>
												<button id="popup" alignH="centre">show pop-up</button>
											</vertical>;
		
		protected static const LAYOUT1:XML = <vertical background="#EEEEEE,#FFFFFF" colour="#99CC99">
												<button alignH="fill" colour="#990000"><font size="50" color="#FF3333"><b>big button</b></font></button>
												<horizontal>
													<button>hello</button>
													<input alignH="fill" background="#445544,#EEFFEE,#889988"/>
												</horizontal>
												<horizontal>
													<label id="label0">hello world</label>
													<button colour="#ff9000">hi</button>
													<vertical colour="#0000ff">
														<button alignH="fill">vertical1</button>
														<button>vertical2</button>
													</vertical>
												</horizontal>
												<horizontal>
													<switch id="switch" colour="#666699"/>
													<switch colour="#FF8000">YES,NO</switch>
													<image id="image0" alignH="right">48</image>
												</horizontal>
											</vertical>;
		
		protected static const LIST0:XML = <list id="list0" colour="#FFFFFF" background="#CCCCCC,#FFFFFF">												
												<horizontal>
													<image id="image">48</image>
													<vertical>
														<label id="label"><font size="18"/></label>
														<label id="label2"><font color="#666666" size="11"/></label>
													</vertical>
												</horizontal>
											</list>;
		
		protected static const LIST1:XML = <list id="list1" gapV="16" background="#EEFFEE,#778877" colour="#000000">	
												{FRUIT_DATA}												
												<horizontal>
													<label id="label"><font color="#FFDDCC"/></label>
													<arrow colour="#FFDDCC" alignH="right"/>
												</horizontal>								
											</list>;
		
		protected static const LIST2:XML = <list id="list2" background="#AAAACC,#AAAACC,#9999CC" colour="#AAAACC">
												{FRUIT_DATA}
												<font color="#FFFFFF"/>											
											</list>;
		
		protected static const TICK_LIST:XML = <tickOneList gapV="6" id="tickList" colour="#BBBBCC" tickColour="#333344" background="#FFFFFF,#FFFFFF,#F3F3FF">
													{FRUIT_DATA}
												</tickOneList>;
		
		protected static const PICKER:XML = <columns gapH="0" background="#9999AA">
														<picker id="picker1" colour="#FFFFFF" background="#CC9999" index="1">
															<font color="#FFFFFF"/>
															{DATA}
														</picker>
														<picker index="3">
															{DATA}
														</picker>
														<picker index="5">
															{DATA}
														</picker>
													</columns>;
															
		protected static const PICKER_SLIDER:XML = <vertical>
														{PICKER}
														<slider id="slider1" value="0.2" alignH="fill"/>
														<slider id="slider2" value="0.2" width="130" background="#CCCC00,#999933,#AAAA99"/>	
													</vertical>
		
		protected static const FLIPPER:XML = <viewFlipper background="#CCCC00,#CCCC33" scrollBarColour="#FFFFFF">
												{LAYOUT0}
												{PICKER_SLIDER}
												{LAYOUT1}
											</viewFlipper>;
		
		protected static const LIST_GROUPS_RENDERER:XML = <groupedList id="list3" background="#C6CCD6,#FFFFFF" colour="#CCCCCC" gapH="32" gapV="4" alignV="centre">
															{GROUPED_DATA}															
															<horizontal>
																<label id="label"><font size="18"/></label>
																<switch id="switch" colour="#996600" alignH="right"/>
															</horizontal>
														</groupedList>;
		
		protected static const DIVIDED_LIST:XML = 	<dividedList>
														<search id="search"/>
														{GROUPED_DATA}
													</dividedList>;
		
		protected static const NAVIGATOR:XML = <navigation title="lists" background="#FFFFFF" colour="#666677" id="navigator">
													{LIST0}
													{LIST1}
													{LIST2}
													{DIVIDED_LIST}
													{LIST_GROUPS_RENDERER}
													{TICK_LIST}
												</navigation>;
		
		protected static const TAB_NAVIGATOR:XML = <tabPages id="tabPages" stageColour="#99AA99,#999999" colour="#111122">
														{NAVIGATOR}
														{FLIPPER}
													</tabPages>;
		
		protected static const POPUP_WINDOW:XML = <vertical alignH="fill">
													<columns gapH="0">
														<picker id="picker1" background="#FFFFEE">
															{DATA}
														</picker>
														<picker id="picker1" background="#EEEEFF">
															{DATA}
														</picker>
													</columns>
													<columns>
														<button colour="#669966" id="cancel">cancel</button>
														<button colour="#996666" id="ok">ok</button>
													</columns>
												</vertical>;
		
		protected static const POPUP_MESSAGE:XML = <vertical alignH="fill">
														<label><font color="#CCCCCC">The search isn't actually rigged up to anything in this demonstration</font></label>
														<image/>
														<button id="ok" background="#9999AA">OK</button>
													</vertical>;		
		
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
		
		
		protected static const PICTURES:Vector.<Class> = new <Class>[MP3, MP4, PALM, PSP, USB];
		protected static const FRUIT:Vector.<String> = new <String>["Apple","Orange","Banana","Pineapple","Lemon","Mango","Plum","Cherry","Lime","Peach","Pomegranate","Grapefruit","Strawberry","Melon"];
		
		protected var _popUp:UIWindow;
		protected var _popUpMessage:UIWindow;
		protected var uiSwitch:UISwitch;
		
		protected var _slider1:UISlider;
		protected var _slider2:UISlider;
		
		protected var _navigator:UINavigation;
		
		
		public function MadComponents(screen:Sprite = null) {
			var i:int;
			
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, TAB_NAVIGATOR);
			
			var player:UILabel = UILabel(UI.findViewById("player"));
			player.text = "playerType="+Capabilities.playerType;

			//Set up the tab buttons
			var uiTabPages:UITabPages = UITabPages(UI.findViewById("tabPages"));
			uiTabPages.setTab(0, "lists", LIST_ICON);
			uiTabPages.setTab(1,"view flipper", VIEWS_ICON);
			
			//Populate the first list
			var data0:Array = [];
			for (i=0; i<FRUIT.length; i++) {
				data0.push({label:FRUIT[i], image:getQualifiedClassName(PICTURES[i%PICTURES.length]), label2:'here is some small text'});
			}
			var uiList1:UIList = UIList(UI.findViewById("list0"));
			uiList1.data = data0;

			//Set up an images
			var image0:UIImage = UIImage(UI.findViewById("image0"));
			image0.imageClass = PALM;
			
			//Write to a text label
			var label0:UILabel = UILabel(UI.findViewById("label0"));
			label0.defaultTextFormat = new TextFormat("Arial",14,0xFFFFFF);
			label0.text = "White text";
			
			//Set up navigation right buttons and listeners
			_navigator = UINavigation(UI.findViewById("navigator"));
			_navigator.addEventListener(Event.CHANGE,navigatorChange);
			_navigator.navigationBar.rightArrow.visible = true;
			_navigator.navigationBar.rightArrow.addEventListener(MouseEvent.MOUSE_UP,nextList);
			_navigator.navigationBar.rightButton.addEventListener(UIButton.CLICKED,goBack);
			
			//Listen for switch
			uiSwitch = UISwitch(UI.findViewById("switch"));
			uiSwitch.addEventListener(Event.CHANGE,toggleActivity);
			
			//Listen for search
			var uiSearch:UISearch = UISearch(UI.findViewById("search"));
			uiSearch.addEventListener(FocusEvent.FOCUS_OUT,showPopUpMessage);

			//Set up a pop-up message		
			_popUpMessage = UI.createPopUp(POPUP_MESSAGE,200.0,90.0);
			UI.hidePopUp(_popUpMessage);
			var okBtn:UIButton = UIButton(_popUpMessage.findViewById("ok"));
			okBtn.addEventListener(UIButton.CLICKED,hidePopUpMessage);
			
			//Listen to slider
			_slider1 = UISlider(UI.findViewById("slider1"));
			_slider1.addEventListener(Event.CHANGE,change);
			
			_slider2 = UISlider(UI.findViewById("slider2"));
			
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
		
		
		protected function showPopUpMessage(event:FocusEvent):void {
			if (!_popUpMessage.visible)
				UI.showPopUp(_popUpMessage);
		}
		
		
		protected function hidePopUpMessage(event:Event):void {
			UI.hidePopUp(_popUpMessage);
		}		
		
		
		protected function toggleActivity(event:Event):void {
			if (uiSwitch.state) {
				UI.showActivityIndicator();
			}
			else {
				UI.hideActivityIndicator();
			}
		}
		
		
		protected function showPopUp(event:Event):void {
			UI.showPopUp(_popUp);
		}
		
		
		protected function hidePopUp(event:Event):void {
			UI.hidePopUp(_popUp);
		}
		
		
		protected function change(event:Event):void {
			_slider2.value = _slider1.value;
		}
		
		
		protected function nextList(event:Event):void {
			_navigator.nextPage(UIPages.SLIDE_LEFT);
			navigatorChange();
		}
		
		
		protected function goBack(event:Event):void {
			_navigator.previousPage(UIPages.SLIDE_RIGHT);
			navigatorChange();
		}
		
		
		protected function navigatorChange(event:Event=null):void {
			var lastPage:Boolean = _navigator.pageNumber == _navigator.pages.length -1;
			_navigator.navigationBar.rightArrow.visible = !lastPage;
			_navigator.navigationBar.rightButton.visible = lastPage;
		}

	}
}