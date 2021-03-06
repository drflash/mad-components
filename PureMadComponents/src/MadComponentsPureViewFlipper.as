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
	
	import pureHelpers.UIFormMaker;
	
	
	public class MadComponentsPureViewFlipper extends Sprite {
		
		protected static const WIDTH:Number = 320.0;
		protected static const HEIGHT:Number = 434.0;
		
		public function MadComponentsPureViewFlipper(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var viewFlipper:UIViewFlipper = new UIViewFlipper(this, <null/>, new Attributes(0, 0, WIDTH, HEIGHT));
			
			var page0:UIFormMaker = new UIFormMaker(viewFlipper, WIDTH, HEIGHT, 'background="#FFCCCC"');
			var page1:UIFormMaker = new UIFormMaker(viewFlipper, WIDTH, HEIGHT, 'background="#CCFFCC"');
			var page2:UIFormMaker = new UIFormMaker(viewFlipper, WIDTH, HEIGHT, 'background="#CCCCFF"');	
			
			viewFlipper.attachPages([page0, page1, page2]);
		}
	}
}