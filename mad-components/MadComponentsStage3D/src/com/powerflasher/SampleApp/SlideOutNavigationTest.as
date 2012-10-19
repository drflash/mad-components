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
import com.danielfreeman.extendedMadness.*;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import com.danielfreeman.stage3Dacceleration.*;


public class SlideOutNavigationTest extends Sprite {
	
	protected static const BIG:XML = <font size="20" color="#FFCCCC"/>;
	
	protected static const GROUPED_DATA:XML =
	
				<data>
					<group>
						<item label="Option 1"/>
						<item label="Option 2"/>
						<item label="Option 3"/>
						<item label="Option 4"/>
					</group>
					<group>
						<item label="Option 5"/>
						<item label="Option 6"/>
						<item label="Option 7"/>
						<item label="Option 8"/>
					</group>
					<group>
						<item label="Option 5"/>
						<item label="Option 6"/>
						<item label="Option 7"/>
						<item label="Option 8"/>
					</group>
				</data>;
	
	
	protected static const DIVIDED_LIST:XML =
	
				<dividedList background="#666666" colour="#CCCCCC" headingColour="#333333" scrollBarColour="#FFFFFF">
					<font color="#FFFFFF"/>
					{GROUPED_DATA}
				</dividedList>;
	
	
	protected static const SLIDE_OUT_NAVIGATION:XML =
	
				<slideOutNavigation title="Slide Out Navigation" colour="#666699">
					{DIVIDED_LIST}
					<vertical alignH="fill" colour="#9999CC" background="#CCCCDD">
						<group gapV="60">
							<label>{BIG}Slide-Out</label>
							<label>{BIG}Navigation</label>
							<label>{BIG}Test</label>
						</group>
						<button width="100"/>
					</vertical>
				</slideOutNavigation>;


		protected var _slideOutNavigation:SlideOutNavigation;


		public function SlideOutNavigationTest() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			UIe.create(this, SLIDE_OUT_NAVIGATION);
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}
		
		
		protected function contextComplete(event:Event):void {
			_slideOutNavigation = new SlideOutNavigation();
			_slideOutNavigation.allListTextures();
        }
		
		

	}
}