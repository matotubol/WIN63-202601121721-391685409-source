package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tab;
   import com.sulake.habbo.utils.WindowToggle;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetPopularRoomTagsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWithHighestScoreSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CompetitionRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomRightsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRecommendedRoomsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GuildBaseSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.GetOfficialRoomsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFavouriteRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.PopularRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomHistorySearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomTextSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyGuildBasesSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFriendsRoomsSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.MyFrequentRoomHistorySearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1904;
   
   public class MainViewCtrl implements ITransitionalMainViewCtrl, class_31, class_13
   {
      
      public static const SEARCHMSG_SEARCH:int = 1;
      
      public static const const_802:int = 2;
      
      public static const SEARCHMSG_OFFICIALROOMS:int = 4;
      
      public static const const_545:int = 5;
      
      private static const BLEND_STAGE_BLENDING_OUT:int = 1;
      
      private static const BLEND_STAGE_LOADING:int = 2;
      
      private static const BLEND_STAGE_REFRESHING:int = 3;
      
      private static const BLEND_STAGE_BLENDING_IN:int = 4;
      
      private static const SCROLLBAR_WIDTH:int = 22;
      
      private static const PANIC_BUTTON_HEIGHT:int = 60;
      
      private var _navigator:HabboNavigator;
      
      private var var_30:class_2250;
      
      private var _content:class_1812;
      
      private var var_377:class_1812;
      
      private var _footer:class_1812;
      
      private var var_352:class_1812;
      
      private var var_1277:PopularTagsListCtrl;
      
      private var _guestRooms:GuestRoomListCtrl;
      
      private var _officialRooms:OfficialRoomListCtrl;
      
      private var var_1418:RoomAdListCtrl;
      
      private var var_3561:CategoryListCtrl;
      
      private var _tabContext:ITabContextWindow;
      
      private var var_3139:Boolean;
      
      private var var_931:int;
      
      private var var_3338:Boolean = true;
      
      private var var_3103:int = 0;
      
      private var _loadingText:class_1741;
      
      private var var_2849:int = 0;
      
      private var var_795:TextSearchInputs;
      
      private var var_908:Timer;
      
      private var _disposed:Boolean = false;
      
      private var var_680:WindowToggle;
      
      private var var_3548:Boolean = false;
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(100,10);
      
      public function MainViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_1277 = new PopularTagsListCtrl(_navigator);
         _guestRooms = new GuestRoomListCtrl(_navigator,0,false);
         _officialRooms = new OfficialRoomListCtrl(_navigator);
         var_1418 = new RoomAdListCtrl(_navigator,0,false);
         var_3561 = new CategoryListCtrl(_navigator);
         var_908 = new Timer(300,1);
         var_908.addEventListener("timer",onResizeTimer);
      }
      
      private static function refreshScrollbar(param1:IViewCtrl, param2:Boolean) : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc5_:class_1741 = null;
         if(param1.content == null || !param1.content.visible)
         {
            return;
         }
         _loc4_ = IItemListWindow(param1.content.findChildByName("item_list"));
         _loc5_ = param1.content.findChildByName("scroller");
         var _loc3_:* = _loc4_.scrollableRegion.height > _loc4_.height;
         if(_loc5_.visible)
         {
            if(!_loc3_)
            {
               _loc5_.visible = false;
               _loc4_.width += 22;
            }
         }
         else if(_loc3_)
         {
            _loc5_.visible = true;
            _loc4_.width -= 22;
         }
      }
      
      public static function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:class_1812) : void
      {
         var _loc3_:class_1741 = param1.content.findChildByName("scroller");
         if(_loc3_ == null || _loc3_.visible)
         {
            return;
         }
         param2.width += 22;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function onNavigatorToolBarIconClick() : void
      {
         if(!var_30)
         {
            reloadData();
            return;
         }
         if(!var_680 || var_680.disposed)
         {
            var_680 = new WindowToggle(var_30,var_30.desktop,reloadData,close);
         }
         var_680.toggle();
      }
      
      private function reloadData() : void
      {
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _navigator = null;
            if(var_30)
            {
               var_30.dispose();
               var_30 = null;
            }
            if(var_680)
            {
               var_680.dispose();
               var_680 = null;
            }
            if(_content)
            {
               _content.dispose();
               _content = null;
            }
            if(var_908)
            {
               var_908.removeEventListener("timer",onResizeTimer);
               var_908.reset();
               var_908 = null;
            }
            if(var_1277)
            {
               var_1277.dispose();
               var_1277 = null;
            }
            if(_guestRooms)
            {
               _guestRooms.dispose();
               _guestRooms = null;
            }
            if(_officialRooms)
            {
               _officialRooms.dispose();
               _officialRooms = null;
            }
            if(var_1418)
            {
               var_1418.dispose();
               var_1418 = null;
            }
            if(var_795)
            {
               var_795.dispose();
               var_795 = null;
            }
         }
      }
      
      public function open() : void
      {
         if(var_30 == null)
         {
            prepare();
         }
         refresh();
         var_30.visible = true;
         var_30.y = Math.max(var_30.y,60);
         var_30.activate();
      }
      
      public function isOpen() : Boolean
      {
         return var_30 != null && Boolean(var_30.visible);
      }
      
      public function close() : void
      {
         if(var_30 != null)
         {
            if(var_795)
            {
               var_795.dispose();
               var_795 = null;
            }
            if(var_680)
            {
               var_680.dispose();
               var_680 = null;
            }
            var_30.dispose();
            var_30 = null;
            _tabContext = null;
            _content = null;
            var_377 = null;
            var_352 = null;
            _footer = null;
            _loadingText = null;
            var_1277.content = null;
            _guestRooms.content = null;
            _officialRooms.content = null;
            var_3561.content = null;
            var_1418.content = null;
            var_2849 = 0;
         }
      }
      
      public function get mainWindow() : class_2250
      {
         return var_30;
      }
      
      private function prepare() : void
      {
         var _loc2_:Boolean = _navigator.getBoolean("eventinfo.enabled");
         var_30 = class_2250(_navigator.getXmlWindow("grs_main_window_new"));
         _tabContext = ITabContextWindow(var_30.findChildByName("tab_context"));
         _content = class_1812(var_30.findChildByName("tab_content"));
         var_377 = class_1812(var_30.findChildByName("custom_content"));
         var_352 = class_1812(var_30.findChildByName("list_content"));
         _footer = class_1812(var_30.findChildByName("custom_footer"));
         _loadingText = var_30.findChildByName("loading_text");
         var _loc3_:class_1741 = var_30.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWindowClose);
         }
         var_30.addEventListener("WE_RESIZED",onWindowResized);
         if(!_loc2_ || !var_3548)
         {
            var _loc4_:Array = [];
            while(_tabContext.numTabItems > 0)
            {
               var _loc7_:ITabButtonWindow = _tabContext.getTabItemAt(0);
               null.push(null);
               _tabContext.removeTabItem(null);
            }
            for each(_loc7_ in null)
            {
               if(!(_loc7_.id == 1 && !_loc2_ || null.id == 6))
               {
                  _tabContext.addTabItem(null);
               }
            }
         }
         for each(var _loc1_ in _navigator.tabs.tabs)
         {
            var _loc5_:ITabButtonWindow = _tabContext.getTabItemByID(_loc1_.id);
            if(_loc5_ != null)
            {
               null.addEventListener("WE_SELECTED",onTabSelected);
               _loc1_.button = null;
            }
         }
         var_30.scaler.setParamFlag(12288,false);
         var_30.scaler.setParamFlag(8192,true);
         var_30.position = DEFAULT_VIEW_LOCATION;
         createSearchInput();
      }
      
      private function createSearchInput() : void
      {
         var _loc1_:class_1812 = null;
         if(var_795 == null)
         {
            _loc1_ = var_30.findChildByName("search_header") as class_1812;
            var_795 = new TextSearchInputs(_navigator,_loc1_);
         }
         var _loc3_:class_1812 = var_30.findChildByName("search_header") as class_1812;
         _loc3_.visible = true;
      }
      
      public function refresh() : void
      {
         if(var_30 == null)
         {
            return;
         }
         refreshTab();
         refreshCustomContent();
         refreshListContent(true);
         refreshFooter();
         var_377.height = Util.getLowestPoint(var_377);
         _footer.height = Util.getLowestPoint(_footer);
         var _loc1_:int = int(var_352.y);
         Util.moveChildrenToColumn(_content,["custom_content","list_content"],var_377.y,8);
         var_352.height = var_352.height + _loc1_ - var_352.y - _footer.height + var_2849;
         Util.moveChildrenToColumn(_content,["list_content","custom_footer"],var_352.y,0);
         var_2849 = _footer.height;
         onResizeTimer(null);
      }
      
      private function refreshTab() : void
      {
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc1_:ISelectableWindow = _tabContext.selector.getSelected();
         if(_loc2_.button != _loc1_)
         {
            var_3139 = true;
            _tabContext.selector.setSelected(_loc2_.button);
         }
      }
      
      private function refreshCustomContent() : void
      {
         Util.hideChildren(var_377);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshCustomContent(var_377);
         if(Util.hasVisibleChildren(var_377))
         {
            var_377.visible = true;
         }
         else
         {
            var_377.visible = false;
            var_377.blend = 1;
         }
      }
      
      private function refreshFooter() : void
      {
         Util.hideChildren(_footer);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshFooter(_footer);
         _footer.visible = Util.hasVisibleChildren(_footer);
      }
      
      private function refreshListContent(param1:Boolean) : void
      {
         Util.hideChildren(var_352);
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc3_:Boolean = _navigator.data.guestRoomSearchArrived && _loc2_.defaultSearchType == 16;
         refreshRoomAds(param1,_loc3_);
         refreshGuestRooms(param1,!_loc3_);
         refreshPopularTags(param1,_navigator.data.popularTagsArrived);
         refreshOfficialRooms(param1,_navigator.data.officialRoomsArrived);
      }
      
      private function refreshGuestRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_guestRooms,"guest_rooms");
      }
      
      private function refreshPopularTags(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_1277,"popular_tags");
      }
      
      private function refreshOfficialRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_officialRooms,"official_rooms");
      }
      
      private function refreshRoomAds(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_1418,"room_ads");
      }
      
      private function refreshCategoryList(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_3561,"categories_container");
      }
      
      private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String) : void
      {
         var _loc5_:class_1741 = null;
         if(param2)
         {
            if(param3.content == null)
            {
               _loc5_ = var_352.findChildByName(param4);
               param3.content = class_1812(_loc5_);
            }
            if(param1)
            {
               param3.refresh();
            }
            param3.content.visible = true;
         }
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         class_21.log("Close navigator window");
         this.close();
      }
      
      private function onTabSelected(param1:class_1758) : void
      {
         var _loc4_:class_1741 = param1.target;
         var _loc2_:int = _loc4_.id;
         if(var_3139)
         {
            var_3139 = false;
            return;
         }
         var _loc3_:Tab = _navigator.tabs.getTab(_loc2_);
         _loc3_.sendSearchRequest();
         switch(_loc3_.id - 1)
         {
            case 0:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS"));
               _navigator.send(new RoomAdEventTabViewedComposer());
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ME"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_CATEGORIES"));
         }
      }
      
      public function reloadRoomList(param1:int) : Boolean
      {
         ErrorReportStorage.addDebugData("MainViewCtrl","Reloading RoomList");
         if(this.isOpen() && this._navigator.data.guestRoomSearchResults != null && this._navigator.data.guestRoomSearchResults.searchType == param1)
         {
            startSearch(_navigator.tabs.getSelected().id,param1,"");
            return true;
         }
         return false;
      }
      
      public function startSearch(param1:int, param2:int, param3:String = "-1", param4:int = 1) : void
      {
         var _loc5_:Tab = _navigator.tabs.getSelected();
         _navigator.tabs.setSelectedTab(param1);
         var _loc6_:Tab = _navigator.tabs.getSelected();
         ErrorReportStorage.addDebugData("StartSearch","Start search " + _loc5_.id + " => " + _loc6_.id);
         if(var_3548)
         {
            if(param3.substr(0,1) == "#")
            {
               param2 = 9;
               param3 = param3.substr(1,param3.length - 1);
            }
         }
         this.var_3338 = _loc5_ != _loc6_;
         if(_loc5_ != _loc6_)
         {
            _loc6_.tabPageDecorator.tabSelected();
         }
         _navigator.data.startLoading();
         if(param4 == 1)
         {
            _navigator.send(getSearchMsg(param2,param3));
         }
         else if(param4 == 2)
         {
            _navigator.send(new GetPopularRoomTagsMessageComposer());
         }
         else if(param4 != 5)
         {
            _navigator.send(new GetOfficialRoomsMessageComposer(_navigator.data.adIndex));
         }
         if(!isOpen())
         {
            open();
            this.var_931 = 2;
            this.var_352.blend = 0;
            if(this.var_377.visible)
            {
               this.var_377.blend = 0;
               this._footer.blend = 0;
            }
         }
         else
         {
            this.var_931 = 1;
         }
         this.var_3103 = 0;
         _navigator.registerUpdateReceiver(this,2);
         sendTrackingEvent(param2);
         _navigator.data.competitionRoomsData = null;
         if(var_3548)
         {
            if(searchInput != null && param3 != "-1")
            {
               if(param2 != 1)
               {
                  searchInput.setText(param3,param2);
               }
            }
         }
      }
      
      private function sendTrackingEvent(param1:int) : void
      {
         switch(param1)
         {
            case 6:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS"));
               break;
            case 7:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS"));
               break;
            case 11:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS"));
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE"));
               break;
            case 9:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH"));
               break;
            case 8:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH"));
               break;
            case 23:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FREQUENT_HISTORY"));
         }
      }
      
      private function getSearchMsg(param1:int, param2:String) : IMessageComposer
      {
         switch(param1)
         {
            case 6:
               return new MyFavouriteRoomsSearchMessageComposer();
            case 3:
               return new MyFriendsRoomsSearchMessageComposer();
            case 7:
               return new MyRoomHistorySearchMessageComposer();
            case 5:
               return new MyRoomsSearchMessageComposer();
            case 1:
               return new PopularRoomsSearchMessageComposer(param2,_navigator.data.adIndex);
            case 4:
               return new RoomsWhereMyFriendsAreSearchMessageComposer();
            case 2:
               return new RoomsWithHighestScoreSearchMessageComposer(_navigator.data.adIndex);
            case 9:
               return new RoomTextSearchMessageComposer("tag:" + param2);
            case 8:
               return new RoomTextSearchMessageComposer(param2);
            case 13:
               return new RoomTextSearchMessageComposer("group:" + param2);
            case 10:
               return new RoomTextSearchMessageComposer("roomname:" + param2);
            case 14:
               return new GuildBaseSearchMessageComposer(_navigator.data.adIndex);
            case 15:
               var _loc3_:class_1904 = _navigator.data.competitionRoomsData;
               return new CompetitionRoomsSearchMessageComposer(null.goalId,null.pageIndex);
            case 16:
            case 17:
               return new RoomAdSearchMessageComposer(_navigator.data.adIndex,param1);
            case 18:
               return new MyRoomRightsSearchMessageComposer();
            case 19:
               return new MyGuildBasesSearchMessageComposer();
            case 20:
               return new RoomTextSearchMessageComposer("owner:" + param2);
            case 22:
               return new MyRecommendedRoomsMessageComposer();
            case 23:
               return new MyFrequentRoomHistorySearchMessageComposer();
            default:
               class_21.log("No message for searchType: " + param1);
               return null;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         if(this.var_352 == null)
         {
            return;
         }
         var _loc2_:Number = param1 / 150;
         if(var_931 == 1)
         {
            _loc3_ = Math.min(1,Math.max(0,this.var_352.blend - _loc2_));
            this.var_352.blend = _loc3_;
            this.var_377.blend = var_3338 ? _loc3_ : 1;
            this._footer.blend = var_3338 ? _loc3_ : 1;
            if(_loc3_ == 0)
            {
               var_931 = 2;
            }
         }
         else if(var_931 == 2)
         {
            if(var_3103 % 10 == 1)
            {
               _loadingText.visible = !_loadingText.visible;
            }
            var_3103 = var_3103 + 1;
            if(!_navigator.data.isLoading())
            {
               var_931 = 3;
            }
         }
         else if(var_931 == 3)
         {
            this.refresh();
            var_931 = 4;
         }
         else
         {
            _loadingText.visible = false;
            _loc3_ = Math.min(1,Math.max(0,this.var_352.blend + _loc2_));
            this.var_352.blend = _loc3_;
            this.var_377.blend = var_3338 ? _loc3_ : 1;
            this._footer.blend = var_3338 ? _loc3_ : 1;
            if(var_352.blend >= 1)
            {
               _navigator.removeUpdateReceiver(this);
            }
         }
      }
      
      private function onWindowResized(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         if(_loc2_ != var_30)
         {
            return;
         }
         if(!this.var_908.running)
         {
            this.var_908.reset();
            this.var_908.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshScrollbar(var_1277,false);
         refreshScrollbar(_guestRooms,false);
         refreshScrollbar(var_1418,false);
         if(_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
         {
         }
      }
      
      public function get searchInput() : TextSearchInputs
      {
         return var_795;
      }
      
      public function openAtPosition(param1:Point) : void
      {
         reloadData();
         if(param1 != null)
         {
            var_30.position = param1;
         }
         else if(var_30.position.x == 0)
         {
            var_30.position = DEFAULT_VIEW_LOCATION;
         }
      }
      
      public function get isPhaseOneNavigator() : Boolean
      {
         return var_3548;
      }
   }
}

