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
	import com.danielfreeman.stage3Dacceleration.*;

	public class PageTransitionTest extends Sprite {
		
		protected static const PAGE0:XML = 

			<navigation id="page0" title="transitions" background="#CCCCCC">
				<clickableGroup id="clickableGroup" gapV="30">
					<label>Slide</label>
					<label>Slide Over</label>
                	<label>Cube</label>
					<label>Door</label>
					<label>Flip</label>
					<label>Swap</label>
					<label>Trash</label>
				</clickableGroup>
			</navigation>;
			
			
		protected static const SLIDE_PAGE:XML = 
		
			<navigation id="page1" background="#666666" colour="#333333">
				<button id="back" alignH="centre" alignV="centre">back</button>
			</navigation>;
			
			
		protected static const LAYOUT:XML =
		
			<pages id="pages">
				{PAGE0}
				{SLIDE_PAGE}
			</pages>;
			
		
		protected static const TRANSITIONS:Vector.<String> =
		
			Vector.<String>([
				PageTransitions.SLIDE_LEFT,
				PageTransitions.SLIDE_OVER_LEFT,
				PageTransitions.CUBE_LEFT,
				PageTransitions.DOOR_LEFT,
				PageTransitions.FLIP_LEFT,
				PageTransitions.SWAP_LEFT,
				PageTransitions.TRASH_DOWN
			]);


		protected var _clickableGroup:UIForm;
		protected var _layout:Sprite;
		protected var _pages:UIPages;
		protected var _page0:UINavigation;
		protected var _page1:UINavigation;
		
		protected var _pageTransitions:PageTransitions;


		public function PageTransitionTest(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			_layout = UI.create(this, LAYOUT);

			_clickableGroup = UIForm(UI.findViewById("clickableGroup"));
            _clickableGroup.addEventListener(UIForm.CLICKED_END, clickHandler);
			
			_pages = UIPages(UI.findViewById("pages"));
			
			var back:UIButton = UIButton(UI.findViewById("back"));
			back.addEventListener(UIButton.CLICKED, goBack);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
			_page0 = UINavigation(UI.findViewById("page0"));
			_page1 = UINavigation(UI.findViewById("page1"));
		}


		protected function contextComplete(event:Event):void {
			_pageTransitions = new PageTransitions();
			_pageTransitions.pageTransitionTextures(_page1, _page0);
        }


		protected function clickHandler(event:Event):void {
			_pageTransitions.goToPage(_pages, 1);
			_pageTransitions.pageTransition(null, null, TRANSITIONS[_clickableGroup.index]);
        }


	//	protected function transitionComplete(event:Event):void {
    //  }


		protected function goBack(event:Event):void {
			_pageTransitions.goToPage(_pages, 0);
			_pageTransitions.goBack(null, null);
		}
	}
}
