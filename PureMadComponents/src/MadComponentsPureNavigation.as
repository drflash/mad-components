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
	
	import pureHelpers.UIFormMaker;
	import pureHelpers.UIListMaker;
	
	public class MadComponentsPureNavigation extends Sprite {
		
		protected static const WIDTH:Number = 320.0;
		protected static const HEIGHT:Number = 434.0;
		
		protected var _list:UIListMaker
		protected var _label:UILabel;
		
		public function MadComponentsPureNavigation(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			

			var navigation:UINavigation = new UINavigation(this, <null/>, new Attributes(0, 0, WIDTH, HEIGHT));
			navigation.title = "Pure Navigation";
			
			_list = new UIListMaker(navigation,
					0, 0, 320.0, 434.0 - UINavigationBar.HEIGHT,
					'background="#CCCCFF,#9999CC,#AAAACC" color="#FFFFFF" size="20"'
				);
			_list.y = 46.0;
			_list.data = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
			_list.addEventListener(UIList.CLICKED, listClicked);
			
			var page:UIFormMaker = new UIFormMaker(navigation, WIDTH, HEIGHT - UINavigationBar.HEIGHT, 'background="#9999FF,#6666CC"');
			
			_label = new UILabel(this, 0, 0, "", new TextFormat("Arial", 32, 0xFFFFFF));
			page.attach(_label);
			
			navigation.attachPages([_list, page]);
		}
		
		
		protected function listClicked(event:Event):void {
			_label.text = String(_list.row);
			_label.x = (WIDTH - _label.width) / 2;
			_label.y = (HEIGHT - UINavigationBar.HEIGHT - _label.height) / 2;
		}
	}
}