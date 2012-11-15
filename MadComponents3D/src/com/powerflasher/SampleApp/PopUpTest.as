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
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.stage3Dacceleration.*;

	/**
	 * @author danielfreeman
	 */
	public class PopUpTest extends Sprite {
		
		protected static const LAYOUT:XML =

			<vertical background="#CCCCCC,#999999">
			   <popUpButton value="show popUp" id="popUpButton">
			  	 <vertical width="200" height="120" curve="1" background="#666677">
				 	<image/>
					<label alignH="centre">
						<font color="#FFFFFF"/>Hello World
					</label>
					<button id="dismiss" alignH="fill" alignV="bottom" curve="0">ok</button>
				</vertical>
			  </popUpButton>
			</vertical>;
		  
		protected var _popUp:UIWindow;
		protected var _panelScaling:PanelScaling;
		protected var _doNothingDefault:DoNothingDefault;

		public function PopUpTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, LAYOUT);
			
			var popUpButton:UIPopUpButton = UIPopUpButton(UI.findViewById("popUpButton"));
			_popUp = popUpButton.createPopUp();
			popUpButton.hidePopUp();
			popUpButton.addEventListener(UIPopUpButton.POPUP_CREATED, popUpCreated);
			popUpButton.addEventListener(UIPopUpButton.CLICKED, doPopUp);
			
			UIButton(_popUp.findViewById("dismiss")).addEventListener(UIButton.CLICKED, dismissPopUp);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}
		
		
		protected function contextComplete(event:Event):void {
			_doNothingDefault = new DoNothingDefault();
			_panelScaling = new PanelScaling();
			_panelScaling.backgroundTexture(IContainerUI(UI.uiLayer));
			_panelScaling.sourcePanelBackground(_popUp);
        }
		
		
		protected function popUpCreated(event:Event):void {
		}


		protected function doPopUp(event:Event):void {
			_panelScaling.popUp(_popUp);
		}
		
		
		protected function dismissPopUp(event:Event):void {
			UI.hidePopUp(_popUp);
		}
		
	}
}
