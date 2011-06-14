package
{
	import com.danielfreeman.madcomponents.*;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MadComponentsJSON extends Sprite {
		
		protected static const TRENDS_VIEW:XML =
			
			<list id="trendsView">
				<model url="http://api.twitter.com/1/trends.json" path="trends" action="loadJSON">
					<name>label</name>
					<url/>
				</model>
			</list>;
		
		
		protected static const TWEETS_VIEW:XML =
			
			<list autoLayout="true" id="tweetsView">
				<model path="results"/>
			
				<horizontal>
					<imageLoader id="profile_image_url"/>
					<vertical gapV="0">
						<label id="from_user" alignH="fill"><font size="12"/></label>
						<label id="text" alignH="fill"><font size="12"/></label>
					</vertical>
				</horizontal>
			</list>;
		
		
		protected static const USER_DETAIL:XML =
			
			<columns id="detail" widths="50,100%">
				<model path="user" autoLayout="true"/>
			
				<imageLoader id="profile_image_url"/>
				<vertical>			
					<label id="name" alignH="fill"/>
					<label id="screen_name"><font size="12"/></label>
					<label id="location" alignH="fill"><font size="12"/></label>
					<label/>
					<label id="description" alignH="fill"><font size="12"/></label>
				</vertical>
			</columns>;
		
		
		protected static const NAVIGATOR:XML =
			
			<navigation id="navigation" rightButton="  " title="Twitter Trends">
				{TRENDS_VIEW}
				{TWEETS_VIEW}
				{USER_DETAIL}
			</navigation>;
				
				
		[Embed(source="images/refresh.png")]
		protected static const REFRESH:Class;
		
		protected var _navigation:UINavigation;
		protected var _trendsView:UIList;
		protected var _tweetsView:UIList;
		protected var _detail:UIForm;
		
		public function MadComponentsJSON() {
			stage.align = StageAlign.TOP_LEFT;  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			UI.create(this, NAVIGATOR);
			
			_trendsView = UIList(UI.findViewById("trendsView"));
			_trendsView.addEventListener(UIList.CLICKED, trendsViewClicked);
			
			_tweetsView = UIList(UI.findViewById("tweetsView"));
			_tweetsView.addEventListener(UIList.CLICKED, tweetsViewClicked);
			
			_detail = UIForm(UI.findViewById("detail"));
			
			_navigation = UINavigation(UI.findViewById("navigation"));
			_navigation.navigationBar.rightButton.skinClass = REFRESH;
			_navigation.navigationBar.rightButton.addEventListener(UIButton.CLICKED, refresh);
			_navigation.navigationBar.backButton.addEventListener(MouseEvent.MOUSE_UP, goBack);
		}
		
		
		protected function refresh(event:Event):void {
			if (_navigation.pageNumber==0)
				_trendsView.model.loadJSON();
			else if (_navigation.pageNumber==1)
				_tweetsView.model.loadJSON();
		}
		
		
		protected function goBack(event:MouseEvent):void {
			_navigation.navigationBar.rightButton.visible = true;
		}
		
		
		protected function trendsViewClicked(event:Event):void {
			var url:String = _trendsView.row.url;
			_tweetsView.model.loadJSON("http://search.twitter.com/search.json"+url.substr(url.indexOf("?")));
			_tweetsView.scrollPositionY = 0;
		}
		
		
		protected function tweetsViewClicked(event:Event):void {
			var user:String = _tweetsView.row.from_user;
			_detail.data = {profile_image_url:null};
			_detail.model.loadXML("http://api.twitter.com/1/users/show.xml?screen_name="+user);
			_navigation.navigationBar.rightButton.visible = false;
		}
	}
}