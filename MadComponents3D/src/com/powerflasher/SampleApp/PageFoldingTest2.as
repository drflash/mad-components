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
	
	import com.danielfreeman.extendedMadness.UIe;
	import com.danielfreeman.madcomponents.*;
	import com.danielfreeman.stage3Dacceleration.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;


	public class PageFoldingTest2 extends Sprite {
		
		[Embed(source="images/buddha.jpg")]
		protected static const BUDDHA:Class;
		
		[Embed(source="images/dragon.jpg")]
		protected static const DRAGON:Class;
		
		[Embed(source="images/faces.jpg")]
		protected static const FACES:Class;
		
		[Embed(source="images/monks.jpg")]
		protected static const MONKS:Class;
		
		[Embed(source="images/temple.jpg")]
		protected static const TEMPLE:Class;
		
		
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
		
		
		protected static const PAGE0:XML =
			
			<pieChart background="#FFFFFF" alignV="centre">{COLOURS}{NUMBERS}</pieChart>;
			
			
		protected static const PAGE1:XML =	

			<barChart background="#FFFFFF" alignV="centre" stack="true" render="3d" order="rows">{COLOURS}{MATRIX2}</barChart>;
			
			
		protected static const PAGE2:XML =	

			<horizontalChart background="#FFFFFF" alignV="centre" render="2d" palette="subtle">{MATRIX}</horizontalChart>;
		
		
		protected static const GRIDPAGE:XML =
		
			<vertical background="#FFFFFF">
				<image>40</image>
				<dataGrid>{MATRIX2}</dataGrid>
				<image>20</image>
				<columns widths="60%,40,40%">
					<vertical gapV="20">
						<dataGrid>{MATRIX}</dataGrid>
						<button width="100">one</button>
						<button width="100">two</button>
						<button width="100">three</button>	
					</vertical>
					<image/>
					<group gapV="40">
						<label>one</label>
						<label>two</label>
						<label>three</label>
					</group>
				</columns>
			</vertical>;
			
			
		protected static const PAGEFORM:XML =
		
			<vertical background="#FFFFFF">
			<vertical width="300" alignH="centre" alignV="centre">
				<columns id="columns1">
					<vertical>
						<horizontal>
							<vertical>
								<checkBox/>
								<checkBox/>
							</vertical>
							<vertical>
								<switch alignH="fill" background="#FF8000">YES,NO</switch>
								<button alignH="fill">button</button>
							</vertical>
						</horizontal>
						<slider id="slider" background="#FF9966"/>
						<progressBar id="progressBar"/>
					</vertical>
					<vertical alignH="fill">
						<switch alt="true" alignH="right"/>
						<segmentedControl background="#CCCCCC,#336633"><data><one/><two/></data></segmentedControl>
						<radioButton>{WHITE}radio button</radioButton>
						<radioButton>{WHITE}radio button</radioButton>
					</vertical>
				</columns>
				</vertical>
			</vertical>;
				
				
		protected static function formatGraphForPage(graph:XML, textColour:String):XML {
			return <rows heights="20%,70%,10%" background={graph.@background}>
				<image/>	
					<columns widths="10%,80%,10%">	
						<image/>	
						{graph}
						<image/>
					</columns>
				<image/>
			</rows>;
		}
				
		
		protected static function latin(colour:String):XML {
		
			return <label width="400"><font color={colour}/>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
			</label>;
		}
		
		
		protected static function makePage(image:Class, pageColour:uint, buttonColour:uint, textColour:String = "#666666"):XML { 

			return <vertical colour={buttonColour} background={pageColour}>
				<vertical alignH="centre" alignV="centre">
					<horizontal>
						<image>{getQualifiedClassName(image)}</image>
						{latin(textColour)}
					</horizontal>
					<button width="100">one</button>
					<button width="100">two</button>
					<button width="100">three</button>					
				</vertical>
			</vertical>;
		}
		
		
		protected static function makeAltPage(image0:Class, image1:Class, pageColour:uint, buttonColour:uint, textColour:String = "#666666"):XML { 

			return <vertical colour={buttonColour} background={pageColour}>
				<columns widths="350,400" alignH="centre" alignV="centre">
					<vertical>
						<image>{getQualifiedClassName(image0)}</image>
						<button width="100">one</button>
						<button width="100">two</button>
						<button width="100">three</button>	
					</vertical>
					<vertical>
						{latin(textColour)}
						<image>{getQualifiedClassName(image1)}</image>
					</vertical>
				</columns>
			</vertical>;
		}
		
		
		protected static const LAYOUT:XML =
		
			<pages id="@pages">
				{formatGraphForPage(PAGE0, "#FFFFFF")}
				{makePage(BUDDHA, 0xFFFFFF, 0xFF9933)}
				{formatGraphForPage(GRIDPAGE, "#FFFFFF")}
				{formatGraphForPage(PAGE1, "#FFFFFF")}
				{makeAltPage(FACES, TEMPLE, 0xFFFFFF, 0xCCCCFF)}
				{formatGraphForPage(PAGEFORM, "#FFFFFF")}
				{formatGraphForPage(PAGE2, "#666633")}
				{makeAltPage(MONKS, DRAGON, 0xFFFFFF, 0x996633, "#999999")}			
			</pages>;

			
		protected var _pages:UIPages;
		protected var _pageFolding:PageFolding;

		
		public function PageFoldingTest2(screen:Sprite = null) {
			if (screen)
				screen.addChild(this);

			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;

			PageFolding.create(this, LAYOUT, -1, -1, true);
		}
	}
}
