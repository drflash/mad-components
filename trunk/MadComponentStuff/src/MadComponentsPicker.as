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
	import flash.events.MouseEvent;

	
	public class MadComponentsPicker extends Sprite {

		protected static const START:XML = <vertical>
												<button id="popup" alignH="centre" alignV="centre">picker pop-up</button>
											</vertical>;
		
		protected static const DATA:XML = <data>
	    									<Red/>
	        								<Orange/>
	        								<Yellow/>
	        								<Green/>
	        								<Blue/>
											<Indigo/>
										 </data>;
		
		protected static const PICKER_EXAMPLE:XML = <vertical alignH="fill">
											<columns gapH="0">
												<picker id="picker1" background="#FFFFFF">
													{DATA}
												</picker>
												<picker id="picker2" background="#FFFFFF">
													{DATA}
												</picker>
											</columns>
											<columns>
												<button colour="#66CC66" id="cancel">cancel</button>
												<button colour="#CC6666" id="ok">ok</button>
											</columns>
										</vertical>;

		protected var _popUp:UIWindow;
		protected var _picker1:UIPicker;
		protected var _picker2:UIPicker;
		
		
		public function MadComponentsPicker(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, START);
			
			//Set up a pop-up window
			_popUp = UI.createPopUp(PICKER_EXAMPLE,180.0,200.0);
			UI.hidePopUp(_popUp);
			
			//references to picker1 and picker2
			_picker1 = UIPicker(_popUp.findViewById("picker1"));
			_picker2 = UIPicker(_popUp.findViewById("picker2"));

			
			//Listeners for showing and hiding pop-up
			var showPopUpButton:UIButton = UIButton(UI.findViewById("popup"));
			showPopUpButton.addEventListener(MouseEvent.MOUSE_UP,showPopUp);
			
			var okButton:UIButton = UIButton(_popUp.findViewById("ok"));
			okButton.addEventListener(MouseEvent.MOUSE_UP,popUpOk);

			var cancelButton:UIButton = UIButton(_popUp.findViewById("cancel"));
			cancelButton.addEventListener(MouseEvent.MOUSE_UP,popUpCancel);
		}
		
		
		protected function showPopUp(event:MouseEvent):void {
			UI.showPopUp(_popUp);
		}
		
		
		protected function popUpOk(event:MouseEvent):void {
			trace("picker1.index="+_picker1.index+" picker2.index="+_picker2.index);
			UI.hidePopUp(_popUp);
		}
		
		
		protected function popUpCancel(event:MouseEvent):void {
			UI.hidePopUp(_popUp);
		}

	}
}