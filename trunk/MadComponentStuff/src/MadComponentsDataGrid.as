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

	
	public class MadComponentsDataGrid extends Sprite {
		
		protected static const DATA_GRID:XML = <vertical background="#FFCC33,#FFDD00">
												<dataGrid id="grid" editable="true" background="#663300,#cc9900,#ff9933">
												<widths>20,20,60</widths>
												<data>
													<header>one,two,three</header>
													<row>1,2,3</row>
													<row>4,5,6</row>
													<row>7,8,9</row>
													<row>2,7,5</row>
												</data>
											</dataGrid>
											<button id="reload" background="#FF6666">reload</button>
											</vertical>;
		

		protected var _testData:Array = [[2,3,4],[5,6,7],[8,9,0],[4,6,8]];
		
		
		public function MadComponentsDataGrid() {
			var i:int;
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UI.create(this, DATA_GRID);

			var button:UIButton = UIButton(UI.findViewById("reload"));
			button.addEventListener(MouseEvent.MOUSE_UP,reload);
		}

		
		protected function reload(event:MouseEvent):void {
			var dataGrid:UIDataGrid = UIDataGrid(UI.findViewById("grid"));
			dataGrid.dataProvider = _testData;
			_testData[1][1] = 1;
			dataGrid.invalidate();
		}

	}
}