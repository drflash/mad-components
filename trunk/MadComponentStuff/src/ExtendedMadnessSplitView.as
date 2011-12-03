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
	import com.danielfreeman.extendedMadness.*;
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	
	public class ExtendedMadnessSplitView extends Sprite
	{
		
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
		
		
		protected static const DETAIL:XML =
			
			<vertical alignV="centre">
				<label id="label" alignH="centre" width="200"/>
			</vertical>;
		

		protected static const LAYOUT:XML =
			
			<splitView id="splitView" topColour="#666666">
				{DATA}
				{DETAIL}
			</splitView>;
				
		
		protected var _splitView:UISplitView;
		
		public function ExtendedMadnessSplitView(screen:Sprite = null) {
			
			if (screen)
				screen.addChild(this);
			
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UIe.createInWindow(this, LAYOUT);
			
			_splitView = UISplitView(UI.findViewById("splitView"));
			_splitView.list.addEventListener(UIList.CLICKED, listClicked);
			_splitView.navigationBar.text = "Split View";
		}
		
		
		protected function listClicked(event:Event):void {
			UIForm(_splitView.pages[0]).data = {label:_splitView.list.row.label};
		}
	}
}