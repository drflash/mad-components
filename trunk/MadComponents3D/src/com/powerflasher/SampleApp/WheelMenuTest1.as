package com.powerflasher.SampleApp {
	
	import flash.utils.getQualifiedClassName;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;	
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.stage3Dacceleration.*;
	import flash.display.Bitmap;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author danielfreeman
	 */
	public class WheelMenuTest1 extends Sprite {
			
			
		protected static const MONTHS:XML =
			
			<data>
				<January/>
				<February/>
				<March/>
				<April/>
				<May/>
				<June/>
				<July/>
				<August/>
				<September/>
				<October/>
				<November/>
				<December/>
			</data>;
			
		
		protected static const LAYOUT:XML =
		
			<vertical stageColour="#333333" >
				<wheelMenu id="@menu" motionBlur="true" orientation="right" radialText="true"
				alignV="centre" alignH="centre"
				rim="5" radius="130"
				background="#222222,#996633,#663300,#FF9900"
				textColour="#FF9999">
					{MONTHS}
				</wheelMenu>
			</vertical>;
			
			
		protected var _wheelMenu:WheelMenu;
		

		public function WheelMenuTest1(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			WheelMenu.create(this, LAYOUT);
		}

	}
}
