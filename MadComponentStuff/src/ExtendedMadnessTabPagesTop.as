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
	import flash.utils.getQualifiedClassName;
	
	public class ExtendedMadnessTabPagesTop extends Sprite
	{
		[Embed(source="images/thailand.png")]
		protected static const THAILAND:Class;
		
		[Embed(source="images/options.png")]
		protected static const OPTIONS:Class;
		
		[Embed(source="images/zoomin.png")]
		protected static const ZOOMIN:Class;
		
		[Embed(source="images/arrow.png")]
		protected static const ARROW:Class;

		
		protected static const WHITE_TEXT:XML = <font color="#EEEEEE"/>;
		
		
		protected static const FRUIT_DATA:XML =
			
			<data>
				<Apple/>
				<Orange/>
				<Banana/>
				<Pineapple/>
				<Lemon/>
				<Mango/>
				<Plum/>
				<Cherry/>
				<Lime/>
				<Peach/>
				<Pomegranate/>
				<Grapefruit/>
				<Strawberry/>
				<Melon/>
			</data>;

								
		protected static const PAGE:XML =
			
			<vertical alignH="fill" colour="#999999">
				<input prompt="input:"/>
				<columns>
					<button>button</button>
					<button>button</button>
				</columns>
				<image/>
				<horizontal>
					<checkBox/>
					<label>{WHITE_TEXT}Checkbox 1</label>
				</horizontal>
				<horizontal>
					<checkBox/>
					<label>{WHITE_TEXT}Checkbox 2</label>
				</horizontal>
				<image/>
				<columns widths="26,100%">
					<vertical>
						<radioButton/>
						<radioButton/>
						<radioButton/>
					</vertical>
					<vertical gapV="12">
						<label>{WHITE_TEXT}Radio Button 1</label>
						<label>{WHITE_TEXT}Radio Button 2</label>
						<label>{WHITE_TEXT}Radio Button 3</label>
					</vertical>
				</columns>
				<segmentedControl alignV="bottom" background="#CCCCCC,#333333">
					<data>
						<one/>
						<two/>
						<three/>
					</data>
				</segmentedControl>
			</vertical>;
		
		
		protected static const SCROLLXY:XML =
			
			<scrollXY mask="true" tapToScale="2.0" stageColour="#666666" scrollBarColour="#FFFFFF" width="480" height="640" border="false" id="scroller">
				<image>
					{getQualifiedClassName(THAILAND)}
				</image>
			</scrollXY>;
		
		
		protected static const LIST:XML =
			
			<list mask="true" scrollBarColour="#FFFFFF">
				{WHITE_TEXT}
				{FRUIT_DATA}
			</list>;
		
		
		protected static const TAB_LAYOUT:XML = 
			
			<tabPagesTop id="tabs" color="#111122" stageColour="#333333">
				{PAGE}
				{SCROLLXY}
				{LIST}
			</tabPagesTop>;
			

		public function ExtendedMadnessTabPagesTop(screen:Sprite = null)
		{
			if (screen)
				screen.addChild(this);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UIList.HIGHLIGHT = 0xFF9933;
			UIe.activate(this);
			UI.create(this, TAB_LAYOUT);
			
			var tabPages:UITabPagesTop = UITabPagesTop(UI.findViewById("tabs"));
			tabPages.setTab(0, "U.I.", OPTIONS);
			tabPages.setTab(1, "scrollXY", ZOOMIN);
			tabPages.setTab(2, "List", ARROW);
		}
	}
}