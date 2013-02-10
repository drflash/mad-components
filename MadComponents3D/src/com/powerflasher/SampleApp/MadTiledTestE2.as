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
	

	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.extendedMadness.UIe;
	import com.danielfreeman.stage3Dacceleration.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;


	public class MadTiledTestE2 extends Sprite {
		
		[Embed(source="images/icons/Adobe Flash Builder.png")]
		protected static const FLASH_BUILDER:Class;
		
		[Embed(source="images/icons/Bookmarks.png")]
		protected static const BOOKMARKS:Class;
		
		[Embed(source="images/icons/Pin.png")]
		protected static const PIN:Class;
		
		[Embed(source="images/icons/Adobe Flash.png")]
		protected static const FLASH:Class;
		
		[Embed(source="images/icons/Calculator.png")]
		protected static const CALCULATOR:Class;
		
		[Embed(source="images/icons/Recycle Bin Full.png")]
		protected static const RECYCLE:Class;
		
		[Embed(source="images/icons/Android.png")]
		protected static const ANDROID:Class;
		
		[Embed(source="images/icons/Computer alt 2.png")]
		protected static const COMPUTER:Class;
		
		[Embed(source="images/icons/Signal.png")]
		protected static const SIGNAL:Class;
		
		[Embed(source="images/icons/Angry Birds.png")]
		protected static const BIRD:Class;
		
		[Embed(source="images/icons/Configure alt 1.png")]
		protected static const CONFIGURE:Class;
		
		[Embed(source="images/icons/User No-Frame.png")]
		protected static const USER:Class;

		[Embed(source="images/icons/App Store alt.png")]
		protected static const APP_STORE:Class;
		
		[Embed(source="images/icons/Facebook.png")]
		protected static const FACEBOOK:Class;
		
		[Embed(source="images/icons/Windows 8.png")]
		protected static const WINDOWS:Class;
		
		[Embed(source="images/icons/Apple.png")]
		protected static const APPLE:Class;
		
		[Embed(source="images/icons/Help.png")]
		protected static const HELP:Class;
		
		[Embed(source="images/icons/iPhone.png")]
		protected static const IPHONE:Class;
		
		[Embed(source="images/icons/iPad.png")]
		protected static const IPAD:Class;
		
		[Embed(source="images/icons/iPod.png")]
		protected static const IPOD:Class;
		
		
		protected static const DATA:XML =
		
				<data>
					<Red/>
					<Orange/>
					<Yellow/>
					<Green/>
					<Blue/>
					<Indigo/>
					<Violet/>
				</data>;

		
		protected static const TITLE:XML =
		
				<vertical tile="2x1" background="#CC6600" border="true">
					<label><font size="170" color="#FFFFFF"/>MC3D</label>
					<label><font color="#FFFFFF"/>Grid Scrolling Demonstration</label>
				</vertical>;
				
				
		protected static const CREDITS:XML =
		
				<vertical tile="2x1" background="#CC6600" border="true">
					<label><font color="#FFFFFF" size="35"/>Grid Scrolling Demonstration</label>
					<label><font color="#FFFFFF" size="30"/>MadComponents, MC3D, and Demo</label>
					<label><font color="#FFFFFF" size="30"/>made by Daniel Freeman</label>
					<label/>
					<label><font color="#FFFFFF" size="30"/>Icons by dAKirby309 (Michael)</label>						
				</vertical>;
				
				
		protected static const PICKER:XML =
		
				<columns id="picker" gapH="0" background="#9999AA" pickerHeight="180">
					<picker colour="#FFFFFF" background="#EECC66">
						<font color="#996633"/>
						{DATA}
					</picker>
					<picker>
						{DATA}
					</picker>
					<picker>
						{DATA}
					</picker>
				</columns>;

		
		protected static function formatForIcon(image:Class, tile:int = 1, colour:uint = 0xCCCCCC):XML {
			return <vertical border="false" tile={tile.toString()+"x1"}>
						<image alignV="centre">{getQualifiedClassName(image)}</image>
					</vertical>;
		}
		
		
		protected static const GRID:Vector.<Vector.<XML>> = Vector.<Vector.<XML>>([
			Vector.<XML>([TITLE, null, formatForIcon(BOOKMARKS), formatForIcon(HELP), null, formatForIcon(PIN), formatForIcon(CALCULATOR), formatForIcon(RECYCLE)]),
			Vector.<XML>([formatForIcon(FLASH_BUILDER), formatForIcon(ANDROID), formatForIcon(COMPUTER), formatForIcon(SIGNAL), null, formatForIcon(BIRD), CREDITS, null]),
			Vector.<XML>([formatForIcon(APP_STORE), formatForIcon(APPLE), formatForIcon(FACEBOOK), formatForIcon(WINDOWS), null, formatForIcon(IPHONE), formatForIcon(CONFIGURE), null])
		]);
			
		
		protected static const PAGE:XML =
		
			<vertical background="#99CC99,#669966,#336633">
				<image>40</image>
				<columns widths="40,100%,40">
					<image/>
					{PICKER}
					<image/>
				</columns>
				<button id="dismiss" alignH="fill" alignV="bottom" background="#336633" curve="0">ok</button>
			</vertical>;
			
			
		protected var _tiledUI:GridScrollingE;
		protected var _popUp:UIWindow;
		protected var _picker:UIForm;

		
		public function MadTiledTestE2(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UIe.create(this, <label/>);

			_popUp = UI.createPopUp(PAGE, 500, 300, 0);
			UI.hidePopUp(_popUp);
			_popUp.findViewById("dismiss").addEventListener(UIButton.CLICKED, dismissHandler);
			_picker = UIForm(_popUp.findViewById("picker"));
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}


		protected function contextComplete(event:Event):void {
			_tiledUI = new GridScrollingE(0x002040);
			_tiledUI.defineGrid(GRID, 0, 200);
			_tiledUI.start();
			_tiledUI.pageTexture(_popUp);
			_tiledUI.addSwapFlipTexture(0, 1, formatForIcon(FLASH));
			_tiledUI.addSwapFlipTexture(5, 2, formatForIcon(IPAD));
			addEventListener(GridScrolling.CLICKED, gridClicked);
		}
		
		
		protected function gridClicked(event:Event):void {
			_tiledUI.flipAroundClicked();
			UI.showPopUp(_popUp);
		}
		
		
		protected function dismissHandler(event:Event):void {
			_tiledUI.updatePage(0, _picker);
			_tiledUI.flipBack();
			UI.hidePopUp(_popUp);
		}
	}
}
