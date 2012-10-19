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
	public class PanelScaleTest extends Sprite {
		
		
	protected static const SIDE_PANEL:XML =
	
		<group background="#CCCCCC">													
			<label alignH="centre"><font color="#333333" size="20">Side Panel</font></label>
		</group>;
		
		protected static const BIG_TEXT:XML = <font size="40"/>;
		
		protected static const MATRIX:XML =
		
				<data>
					<row>1,2,3,4</row>
					<row>3,8,4,1</row>
					<row>4,1,5,12</row>
				</data>;

		protected static const NUMBERS:XML = <data>3,5,4,2,1</data>;
		
		protected static const COLOURS:XML = <colours>#99FF99,#CC9999,#9999CC,#CCCC66,#CC9966</colours>;
					
		
		protected static const LAYOUT:XML =
		   <frame border="false" stageColour="#CCCCFF">
				<columns widths="80%,20%">
					<image/>
					<rows id="scene0" border="true" background="#EEFFEE,#EEEEEE,20">
						{SIDE_PANEL}
						<barChart stack="true">{COLOURS}{MATRIX}</barChart>
						<button id="expand">expand</button>
					</rows>
				</columns>
				<columns widths="30%,70%">
					<image/>
					<rows id="scene1" border="true" background="#EEFFEE,#EEEEEE,20">
						{SIDE_PANEL}
						<barChart>{COLOURS}{MATRIX}</barChart>
						<button id="contract">reduce</button>
					</rows>
				</columns>
		  </frame>;
	
		protected var _scene0:UIForm;		  
		protected var _scene1:UIForm;
	
		protected var _doNothingDefault:DoNothingDefault;	
		protected var _panelScaling:PanelScaling;

		public function PanelScaleTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, LAYOUT);
			
			_scene0 = UIForm(UI.findViewById("scene0"));
			_scene1 = UIForm(UI.findViewById("scene1"));
			
			_scene1.visible = false;
			
			UIButton(UI.findViewById("expand")).addEventListener(UIButton.CLICKED, expandSidePanel);
			UIButton(UI.findViewById("contract")).addEventListener(UIButton.CLICKED, contractSidePanel);
			
			addEventListener(PanelScaling.SCALE_COMPLETE, scaleComplete);
			addEventListener(PanelScaling.REVERSE_COMPLETE, reverseComplete);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}
		
		
		protected function contextComplete(event:Event):void {
			_doNothingDefault = new DoNothingDefault();
			_panelScaling = new PanelScaling();
			_panelScaling.backgroundColour = 0xFFEEFFEE;
			_panelScaling.backgroundTexture(IContainerUI(UI.uiLayer));
			_panelScaling.sourcePanelBackground(_scene0);
			_panelScaling.destinationPanelBackground(_scene1);
        }
		
		
		protected function expandSidePanel(event:Event):void {
			_panelScaling.scaleEffect();
		}
		
		
		protected function contractSidePanel(event:Event):void {
			_panelScaling.goBack();
		}
		
		
		protected function scaleComplete(event:Event):void {
			_scene0.visible = false;
			_scene1.visible = true;
		}
		
		
		protected function reverseComplete(event:Event):void {
			_scene0.visible = true;
			_scene1.visible = false;
		}
		
	}
}
