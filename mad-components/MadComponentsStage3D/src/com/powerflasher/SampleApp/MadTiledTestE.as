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
	import com.danielfreeman.extendedMadness.UIe;
	import com.danielfreeman.stage3Dacceleration.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	public class MadTiledTestE extends Sprite {
		
		protected static const WHITE:XML = <font color="#FFFFFF"/>;
			
		protected static const MATRIX:XML = <data>
			<row>1,2,3,4</row>
			<row>3,8,4,1</row>
			<row>4,1,5,12</row>
		</data>;
		
		protected static const MATRIX2:XML = <data>
			<row>1,2,3,4,2,7,4,6</row>
			<row>3,8,4,1,9,5,7,2</row>
			<row>4,1,5,8,3,6,4,5</row>
			<row>1,2,6,4,5,2,8,3</row>
		</data>;

		protected static const NUMBERS:XML = <data>3,5,4,2,1</data>;
		
		protected static const COLOURS:XML = <colours>#99FF99,#CC9999,#9999CC,#CCCC66,#CC9966</colours>;
		
		protected static const NUMBER_OF_PAGES:int = 9;
		
			
		protected static const PAGE0:XML =
			
			<pieChart background="#DDCCCC,#EEEEEE" alignV="centre">{COLOURS}{NUMBERS}</pieChart>;
			
			
		protected static const PAGE1:XML =	

			<barChart background="#CC44FF,#663399" alignV="centre" stack="true" render="3d" order="rows">{COLOURS}{MATRIX2}</barChart>;
			
			
		protected static const PAGE2:XML =	

			<barChart background="#CCCCFF,#CCCCCC,6" alignV="centre" render="2d" stack="true" order="rows" palette="subtle">{MATRIX}</barChart>;
			
			
		protected static const PAGE3:XML =	

			<barChart background="#CCCCFF,#FF8000" alignV="centre" render="3d" order="rows" palette="rainbow">{NUMBERS}</barChart>;
			
			
		protected static const PAGE4:XML =	

			<horizontalChart background="#FFFFCC,#CCFFCC" alignV="centre" render="2d" palette="subtle">{MATRIX}</horizontalChart>;
			
			
		protected static const PAGE5:XML =	

			<pieChart background="#CC6666,#993333" render="2d" alignV="centre" palette="subtle">{NUMBERS}</pieChart>;
			
		
		protected static const PAGE6:XML =	

			<barChart background="#666666,#CCCCCC" alignV="centre" render="2d" order="rows" palette="greyscale1">{MATRIX}</barChart>;

			
		protected static const PAGE7:XML =	

			<barChart background="#CC4433,#663333" alignV="centre" render="2d" order="columns">{MATRIX2}</barChart>;
			
			
		protected static const PAGE8:XML =	

			<lineChart background="#DDCCCC,#EEEEEE" palette="greyscale0" alignV="centre">{MATRIX2}</lineChart>;
		
		
		
		
		
		protected static function formatForPage(graph:XML, title:String):XML {
			return <vertical background={graph.@background}>
				<label>{WHITE}{title}</label>
				<line/>	
				<columns widths="5%,90%,5%">	
					<image/>	
					{graph}
					<image/>
				</columns>
			</vertical>;
		}
		
		
		protected static function formatForIcon(graph:XML, tile:int = 1):XML {
			return <columns tile={tile.toString()+"x"+tile.toString()} background={graph.@background} widths="5%,90%,5%">	
					<image/>
					<vertical>
						<image>20</image>
						{graph}
					</vertical>
					<image/>
				</columns>;
		}
			
			
		protected static const LAYOUT:XML =
		<rows border="false" heights="100%,38">
			<pages id="views" background="#FFCCFF">
				{formatForPage(PAGE0, "3D Bar Chart")}
				{formatForPage(PAGE1, "3D Bar Charts")}
				{formatForPage(PAGE2, "Stacked Bar Chart")}
				{formatForPage(PAGE3, "3D Bar Chart")}
				{formatForPage(PAGE4, "Horizontal Bar Chart")}
				{formatForPage(PAGE5, "Pie Chart")}	
				{formatForPage(PAGE6, "Bar Chart")}
				{formatForPage(PAGE7, "Bar Chart")}
				{formatForPage(PAGE8, "Line Chart")}
			</pages>
			<columns gapH="0" alignH="fill" colour="#334433">
				<button id="pages" curve="0">Pages</button>
				<button id="flow" curve="0">Flow</button>
				<button id="circle" curve="0">Circle</button>
				<button id="swap" curve="0">Swap</button>
				<button id="grid" curve="0">Grid</button>
			</columns>
		</rows>;
		
		
		protected static const GRID:Vector.<Vector.<XML>> = Vector.<Vector.<XML>>([
			Vector.<XML>([formatForIcon(PAGE0, 2), null, formatForIcon(PAGE1), formatForIcon(PAGE2), formatForIcon(PAGE3), formatForIcon(PAGE4), formatForIcon(PAGE5), formatForIcon(PAGE6)]),
			Vector.<XML>([null, null, formatForIcon(PAGE7), formatForIcon(PAGE8), formatForIcon(PAGE0), formatForIcon(PAGE1, 2), null, formatForIcon(PAGE2)]),
			Vector.<XML>([formatForIcon(PAGE3), formatForIcon(PAGE4), formatForIcon(PAGE5), formatForIcon(PAGE6), formatForIcon(PAGE7), null, null, formatForIcon(PAGE8)])
		]);
			
		
		protected static const PAGE:XML =
		
			<vertical>
				<image/>
				<label alignH="centre">
					<font color="#FFFFFF"/>Hello World
				</label>
				<button id="dismiss" alignH="fill" alignV="bottom" curve="0">ok</button>
			</vertical>;
			
			
		protected var _tiledUI:GridScrollingE;
		protected var _popUp:UIWindow;

		
		public function MadTiledTestE(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			UIe.create(this,<label/>);

			_popUp = UI.createPopUp(PAGE,256,256,0);
			UI.hidePopUp(_popUp);
			_popUp.findViewById("dismiss").addEventListener(UIButton.CLICKED, dismissHandler);
			
			addEventListener(Stage3DAcceleration.CONTEXT_COMPLETE, contextComplete);
			Stage3DAcceleration.startStage3D(this);
		}


		protected function contextComplete(event:Event):void {
			_tiledUI = new GridScrollingE();
			_tiledUI.defineGrid(GRID);
			_tiledUI.start();
			_tiledUI.pageTexture(_popUp);
			_tiledUI.addSwapFlipTexture(0, 0, formatForIcon(PAGE3));
			addEventListener(GridScrolling.CLICKED, gridClicked);
		}
		
		
		protected function gridClicked(event:Event):void {
			_tiledUI.flipAroundClicked();
			UI.showPopUp(_popUp);
		}
		
		
		protected function dismissHandler(event:Event):void {
			_tiledUI.flipBack();
			UI.hidePopUp(_popUp);
		}
	}
}
