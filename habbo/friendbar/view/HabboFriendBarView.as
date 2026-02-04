package com.sulake.habbo.friendbar.view
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.friendbar.data.FriendRequest;
   import com.sulake.habbo.friendbar.data.class_1813;
   import com.sulake.habbo.friendbar.data.class_3462;
   import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
   import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
   import com.sulake.habbo.friendbar.events.NewMessageEvent;
   import com.sulake.habbo.friendbar.events.NotificationEvent;
   import com.sulake.habbo.friendbar.view.tabs.FriendEntityTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendRequestTab;
   import com.sulake.habbo.friendbar.view.tabs.FriendRequestsTab;
   import com.sulake.habbo.friendbar.view.tabs.ITab;
   import com.sulake.habbo.friendbar.view.tabs.NewFriendEntityTab;
   import com.sulake.habbo.friendbar.view.tabs.NewFriendRequestTab;
   import com.sulake.habbo.friendbar.view.tabs.Tab;
   import com.sulake.habbo.friendbar.view.tabs.class_2992;
   import com.sulake.habbo.friendbar.view.tabs.class_3069;
   import com.sulake.habbo.friendbar.view.tabs.tokens.Token;
   import com.sulake.habbo.friendbar.view.utils.FriendListIcon;
   import com.sulake.habbo.friendbar.view.utils.MessengerIcon;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.iid.IIDHabboFriendBarData;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class HabboFriendBarView extends AbstractView implements class_1962, class_259, ILinkEventTracker
   {
      
      private static const TAB_WIDTH:int = 127;
      
      private static const const_332:int = 1;
      
      private static const USE_TOGGLE_WINDOW:Boolean = false;
      
      private static const const_517:int = 3;
      
      private static const MAIN_WINDOW_RESOURCE:String = "new_bar_xml";
      
      private static const TOGGLE_WINDOW_RESOURCE:String = "toggle_xml";
      
      private static const BORDER:String = "border";
      
      private static const LIST:String = "list";
      
      private static const HEADER:String = "header";
      
      private static const CANVAS:String = "canvas";
      
      private static const PIECES:String = "pieces";
      
      private static const TOOLS:String = "friendtools";
      
      private static const const_1254:String = "collapse_left";
      
      private static const BUTTON_COLLAPSE_RIGHT:String = "collapse_right";
      
      private static const const_1244:String = "button_left";
      
      private static const const_717:String = "button_right";
      
      private static const BUTTON_LEFT_PAGE:String = "button_left_page";
      
      private static const BUTTON_RIGHT_PAGE:String = "button_right_page";
      
      private static const const_1232:String = "button_left_end";
      
      private static const const_1221:String = "button_right_end";
      
      private static const const_598:String = "button_close";
      
      private static const const_444:String = "button_open";
      
      private static const LINK_FRIEND_LIST:String = "link_friendlist";
      
      private static const ICON_FIND_FRIENDS:String = "icon_find_friends";
      
      private static const ICON_ALL_FRIENDS:String = "icon_all_friends";
      
      private static const COLLAPSED_MARGIN:int = 150;
      
      private static const NEW_BAR_BOTTOM_OFFSET:int = 1;
      
      private static const NEW_BAR_RIGHT_MARGIN:int = 16;
      
      private var _friendBarData:class_1813;
      
      private var _gameManager:class_45;
      
      private var _friendList:class_258;
      
      private var _toolbar:IHabboToolbar;
      
      private var var_40:class_1812;
      
      private var var_534:class_1812;
      
      private var var_368:class_1812;
      
      private var var_86:Vector.<ITab>;
      
      private var var_500:ITab;
      
      private var var_1027:int = -1;
      
      private var var_369:int = 0;
      
      private var var_2368:TextCropper;
      
      private var var_1536:FriendListIcon;
      
      private var var_2618:MessengerIcon;
      
      private var var_422:class_1812;
      
      private var var_5183:class_3069;
      
      private var var_3687:Boolean = true;
      
      private var var_731:Timer;
      
      private var var_1023:Boolean = false;
      
      private var var_2256:IRegionWindow;
      
      private var var_2403:IRegionWindow;
      
      private var var_4457:Boolean = false;
      
      private var var_2439:IStaticBitmapWrapperWindow;
      
      private var var_323:Timer;
      
      private var _notifyMessengerOnStartup:Boolean = false;
      
      public function HabboFriendBarView(param1:class_15, param2:uint, param3:class_40)
      {
         super(param1,param2,param3);
         var_2368 = new TextCropper();
         var_86 = new Vector.<ITab>();
         var_86 = new Vector.<ITab>();
      }
      
      public function setMessengerIconNotify(param1:Boolean) : void
      {
         if(var_2618)
         {
            var_2618.notify(param1);
         }
         if(var_422)
         {
            notifyMessenger(param1);
         }
      }
      
      public function get friendBarWidth() : int
      {
         return var_40 == null ? 0 : (var_1023 ? 150 : int(var_40.width));
      }
      
      public function setFriendListIconNotify(param1:Boolean) : void
      {
         if(var_1536)
         {
            var_1536.notify(param1);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDHabboFriendBarData(),function(param1:class_1813):void
         {
            _friendBarData = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_45):void
         {
            _gameManager = param1;
         })]);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_323 != null)
            {
               var_323.removeEventListener("timer",onTimerEvent);
               var_323.stop();
               var_323 = null;
            }
            if(var_731)
            {
               var_731.removeEventListener("timerComplete",onRemoveDimmer);
               var_731 = null;
            }
            if(var_2618)
            {
               var_2618.dispose();
               var_2618 = null;
            }
            if(var_1536)
            {
               var_1536.dispose();
               var_1536 = null;
            }
            if(var_368)
            {
               var_368.dispose();
               var_368 = null;
            }
            if(var_40)
            {
               var_40.dispose();
               var_40 = null;
            }
            if(var_534)
            {
               var_534.dispose();
               var_534 = null;
            }
            while(var_86.length > 0)
            {
               ITab(var_86.pop()).dispose();
            }
            while(var_86.length > 0)
            {
               ITab(var_86.pop()).dispose();
            }
            if(_friendBarData != null && !_friendBarData.disposed && _friendBarData.events != null)
            {
               _friendBarData.events.removeEventListener("FBE_UPDATED",onRefreshView);
               _friendBarData.events.removeEventListener("FIND_FRIENDS_RESULT",onFindFriendsNotification);
               _friendBarData.events.removeEventListener("FBE_REQUESTS",onFriendRequestUpdate);
               _friendBarData.events.removeEventListener("FBE_MESSAGE",onNewInstantMessage);
               _friendBarData.events.removeEventListener("FBE_NOTIFICATION_EVENT",onFriendNotification);
               _friendBarData.events.removeEventListener("AMC_EVENT",onRefreshMessengerConversations);
            }
            if(_sessionDataManager)
            {
               _sessionDataManager.events.removeEventListener("APUE_UPDATED",onSessionDataPreferences);
            }
            if(_windowManager != null && !_windowManager.disposed)
            {
               _windowManager.getWindowContext(1).getDesktopWindow().removeEventListener("WE_RESIZED",onDesktopResized);
            }
            var_2368.dispose();
            var_2368 = null;
            super.dispose();
         }
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _friendBarData.events.addEventListener("FBE_UPDATED",onRefreshView);
         _friendBarData.events.addEventListener("FIND_FRIENDS_RESULT",onFindFriendsNotification);
         _friendBarData.events.addEventListener("FBE_REQUESTS",onFriendRequestUpdate);
         _friendBarData.events.addEventListener("FBE_MESSAGE",onNewInstantMessage);
         _friendBarData.events.addEventListener("FBE_NOTIFICATION_EVENT",onFriendNotification);
         _friendBarData.events.addEventListener("AMC_EVENT",onRefreshMessengerConversations);
         _sessionDataManager.events.addEventListener("APUE_UPDATED",onSessionDataPreferences);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_40)
         {
            var_40.visible = param1;
            var_40.activate();
         }
         if(var_368)
         {
            var_368.visible = !param1;
            if(var_40)
            {
               var_368.x = var_40.x;
               var_368.y = var_40.y;
               var_368.activate();
            }
         }
      }
      
      private function addDimmerToFriendBar() : void
      {
         var _loc1_:class_1741 = _windowManager.createWindow("bar_dimmer","",30,1,0x80 | 0x0800 | 1,new Rectangle(0,0,var_40.width,var_40.height),null,0);
         _loc1_.color = 0;
         _loc1_.blend = 0.3;
         var_40.addChild(_loc1_);
         var_40.invalidate();
         if(var_731 == null)
         {
            var_731 = new Timer(RoomEnterEffect.totalRunningTime,1);
            var_731.addEventListener("timerComplete",onRemoveDimmer);
            var_731.start();
         }
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         var_731.removeEventListener("timerComplete",onRemoveDimmer);
         var_731 = null;
         var _loc2_:class_1741 = var_40.findChildByName("bar_dimmer");
         if(_loc2_ != null)
         {
            var_40.removeChild(_loc2_);
            _windowManager.destroy(_loc2_);
         }
      }
      
      public function get visible() : Boolean
      {
         return var_40 && var_40.visible;
      }
      
      public function populate() : void
      {
         var _loc6_:* = 0;
         if(var_40 == null)
         {
            return;
         }
         var _loc14_:int = var_1027;
         deSelect(false);
         var _loc10_:IItemListWindow = var_40.findChildByName("list") as IItemListWindow;
         if(_loc10_ == null)
         {
            return;
         }
         _loc10_.autoArrangeItems = false;
         var _loc4_:int;
         _loc6_ = _loc4_ = _loc10_.numListItems;
         while(_loc6_ > 0)
         {
            _loc10_.removeListItemAt(_loc6_ - 1);
            _loc6_--;
         }
         while(var_86.length > 0)
         {
            var_86.pop().recycle();
         }
         updateFriendRequestCounter(_friendBarData.numFriendRequests);
         var _loc3_:int = _friendBarData.numFriends;
         var _loc1_:int = maxNumOfTabsVisible;
         var _loc12_:int = _loc3_ + (var_3687 ? 1 : 0) + 0;
         var _loc13_:int = Math.min(_loc1_,_loc12_);
         if(var_369 + _loc13_ > _loc12_)
         {
            var_369 = Math.max(0,var_369 - (var_369 + _loc13_ - _loc12_));
         }
         var _loc8_:int = var_369;
         _loc6_ = _loc8_;
         while(_loc6_ < _loc3_ + _loc8_)
         {
            if(_loc6_ >= _loc3_)
            {
               break;
            }
            if(var_86.length >= _loc1_)
            {
               break;
            }
            var _loc15_:class_3462 = _friendBarData.getFriendAt(_loc6_);
            if(_loc15_.id > 0)
            {
               var _loc9_:Tab = NewFriendEntityTab.allocate(null);
               var_86.push(null);
               _loc10_.addListItem(null.window);
            }
            _loc6_++;
         }
         if(var_3687)
         {
            var _loc7_:int = getNumberOfFindFriendsTabs(_loc1_,_loc12_,_loc3_,0);
            _loc12_ = _loc3_ + 0 + 0;
            while(0 > ((_loc7_--,0)))
            {
               var _loc11_:Tab = class_2992.allocate();
               _loc10_.addListItem(null.window);
               var_86.push(null);
            }
         }
         _loc10_.autoArrangeItems = true;
         if(_loc14_ > -1)
         {
            selectFriendEntity(_loc14_);
         }
         setCollapseButtonVisibility();
         toggleArrowButtons(var_86.length < _loc12_ && _loc12_ > 0,var_369 != 0,var_369 + var_86.length < _loc12_);
         if(!var_4457)
         {
            var_4457 = true;
            resizeAndPopulate(false);
            resizeAndPopulate(true);
         }
      }
      
      private function getNumberOfFindFriendsTabs(param1:int, param2:int, param3:int, param4:int) : int
      {
         if(var_86.length >= param1)
         {
            return 0;
         }
         if(var_86.length >= param1)
         {
            return 0;
         }
         if(var_86.length + 1 < 3)
         {
            var _loc5_:int = Math.min(param1 - var_86.length,3 - var_86.length);
         }
         return 1;
      }
      
      private function getFriendEntityTabByID(param1:int) : FriendEntityTab
      {
         var _loc2_:FriendEntityTab = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(var_86.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = var_86[_loc4_] as FriendEntityTab;
            if(_loc2_)
            {
               if(_loc2_.friend.id == param1)
               {
                  return _loc2_;
               }
            }
            _loc4_++;
         }
         return null;
      }
      
      private function isUserInterfaceReady() : Boolean
      {
         return var_40 && !var_40.disposed;
      }
      
      private function buildUserInterface() : void
      {
         Tab.DATA = _friendBarData;
         Tab.GAMES = _gameManager;
         Tab.FRIENDS = _friendList;
         Tab.VIEW = this;
         Tab.ASSETS = assets;
         Tab.WINDOWING = _windowManager;
         Tab.var_439 = _localizationManager;
         Tab.CROPPER = var_2368;
         Tab.TRACKING = _tracking;
         Tab.AVATAR_RENDER_MANAGER = _avatarManager;
         Token.WINDOWING = _windowManager;
         Token.ASSETS = assets;
         Token.GAMES = _gameManager;
         var _loc4_:IAsset = assets.getAssetByName("new_bar_xml");
         var_40 = _windowManager.buildFromXML(_loc4_.content as XML,1) as class_1812;
         var_40.y = var_40.parent.height - (var_40.height + 1);
         var_40.setParamFlag(1024,true);
         var_40.procedure = barWindowEventProc;
         if(RoomEnterEffect.isRunning())
         {
            addDimmerToFriendBar();
         }
         var _loc2_:class_1812 = var_40.findChildByName("friendtools") as class_1812;
         var_2439 = _loc2_.getChildByName("line") as IStaticBitmapWrapperWindow;
         var_422 = class_1812(_loc2_.findChildByName("icon_messenger"));
         if(var_422)
         {
            var_422.addEventListener("WME_CLICK",onOpenMessenger);
            var_422.visible = false;
         }
         var _loc3_:class_1812 = class_1812(_loc2_.findChildByName("icon_all_friends"));
         if(_loc3_)
         {
            _loc3_.addEventListener("WME_CLICK",onOpenFriendsList);
         }
         var _loc1_:class_1812 = class_1812(_loc2_.findChildByName("icon_find_friends"));
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onOpenSearchFriends);
         }
         var_2403 = var_40.findChildByName("collapse_left") as IRegionWindow;
         if(var_2403)
         {
            var_2403.addEventListener("WME_CLICK",onCollapseFriendList);
         }
         var_2256 = var_40.findChildByName("collapse_right") as IRegionWindow;
         if(var_2256)
         {
            var_2256.addEventListener("WME_CLICK",onCollapseFriendList);
         }
         _windowManager.getWindowContext(1).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
         populate();
         if(_notifyMessengerOnStartup)
         {
            notifyMessenger(true);
         }
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         if(_avatarManager)
         {
            var _loc3_:class_1827 = _avatarManager.createAvatarImage(param1,"h",null,this);
         }
         return null;
      }
      
      public function getGroupIconBitmap(param1:String) : BitmapData
      {
         return _sessionDataManager.getGroupBadgeImage(param1);
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc11_:class_3462 = null;
         var _loc3_:int = 0;
         var _loc10_:BitmapData = null;
         var _loc13_:class_1812 = null;
         var _loc6_:IItemListWindow = null;
         var _loc8_:IItemListWindow = var_40.findChildByName("list") as IItemListWindow;
         var _loc9_:int = _friendBarData.numFriends;
         _loc3_ = 0;
         while(_loc3_ < _loc9_)
         {
            _loc11_ = _friendBarData.getFriendAt(_loc3_);
            if(_loc11_.figure == param1)
            {
               _loc10_ = null;
               if(_loc11_.id > 0)
               {
                  _loc10_ = getAvatarFaceBitmap(_loc11_.figure);
               }
               else
               {
                  _loc10_ = getGroupIconBitmap(_loc11_.figure);
               }
               if(_loc10_)
               {
                  _loc13_ = _loc8_.getListItemByID(_loc11_.id) as class_1812;
                  if(_loc13_)
                  {
                     _loc6_ = _loc13_.getChildByName("pieces") as IItemListWindow;
                     if(_loc6_)
                     {
                        var _loc12_:class_1812 = class_1812(_loc6_.getListItemByName("header"));
                        if(_loc12_)
                        {
                           var _loc4_:class_2251 = null.findChildByName("canvas") as class_2251;
                           _loc4_.bitmap = _loc10_;
                           null.width = _loc10_.width;
                           null.height = _loc10_.height;
                        }
                     }
                  }
               }
               return;
            }
            _loc3_++;
         }
         var _loc5_:Array = _friendBarData.getFriendRequestList();
         for each(var _loc2_ in _loc5_)
         {
            if(_loc2_.figure == param1)
            {
               for each(var _loc7_ in var_86)
               {
                  if(_loc7_ is FriendRequestTab)
                  {
                     FriendRequestTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
                  if(_loc7_ is NewFriendRequestTab)
                  {
                     NewFriendRequestTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
                  if(_loc7_ is FriendRequestsTab)
                  {
                     FriendRequestsTab(_loc7_).avatarImageReady(_loc2_,getAvatarFaceBitmap(param1));
                     return;
                  }
               }
            }
         }
      }
      
      private function isFriendSelected(param1:class_3462) : Boolean
      {
         return var_1027 == param1.id;
      }
      
      public function selectTab(param1:ITab, param2:Boolean) : void
      {
         if(!param1.selected)
         {
            if(var_500)
            {
               deSelect(true);
            }
            param1.select(param2);
            var_500 = param1;
            if(param1 is FriendEntityTab)
            {
               var_1027 = FriendEntityTab(param1).friend.id;
            }
            if(param1 is NewFriendEntityTab)
            {
               var_1027 = NewFriendEntityTab(param1).friend.id;
            }
         }
      }
      
      public function selectFriendEntity(param1:int) : void
      {
         if(var_1027 == param1)
         {
            return;
         }
         var _loc2_:FriendEntityTab = getFriendEntityTabByID(param1);
         if(_loc2_)
         {
            selectTab(_loc2_,false);
            var_1027 = param1;
         }
      }
      
      public function deSelect(param1:Boolean) : void
      {
         if(var_500)
         {
            var_500.deselect(param1);
            var_500 = null;
            var_1027 = -1;
         }
      }
      
      public function getIconLocation(param1:String) : class_1812
      {
         var _loc2_:* = null;
         return class_1812(var_40.findChildByName(param1));
      }
      
      private function onRefreshView(param1:Event) : void
      {
         if(!isUserInterfaceReady())
         {
            buildUserInterface();
         }
         else
         {
            resizeAndPopulate(true);
         }
      }
      
      private function onFindFriendsNotification(param1:FindFriendsNotificationEvent) : void
      {
         var event:FindFriendsNotificationEvent = param1;
         var title:String = event.success ? "${friendbar.find.success.title}" : "${friendbar.find.error.title}";
         var text:String = event.success ? "${friendbar.find.success.text}" : "${friendbar.find.error.text}";
         _windowManager.notify(title,text,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         },16);
      }
      
      private function onFriendRequestUpdate(param1:FriendRequestUpdateEvent) : void
      {
         if(var_1536)
         {
            var_1536.notify(_friendBarData.numFriendRequests > 0);
         }
         if(var_40)
         {
            updateFriendRequestCounter(_friendBarData.numFriendRequests);
            resizeAndPopulate(true);
         }
         else
         {
            buildUserInterface();
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
         var_422.visible = true;
         var _loc2_:class_1741 = var_422.getChildByName("icon_1") as class_1741;
         var _loc3_:class_1741 = var_422.getChildByName("icon_2") as class_1741;
         if(_loc2_ && _loc3_)
         {
            if(_loc2_.visible)
            {
               _loc2_.visible = false;
               _loc3_.visible = true;
            }
            else if(_loc3_.visible)
            {
               _loc3_.visible = false;
               _loc2_.visible = true;
            }
         }
      }
      
      private function notifyMessenger(param1:Boolean) : void
      {
         var _loc2_:class_1741 = var_422.getChildByName("icon") as class_1741;
         var _loc3_:class_1741 = var_422.getChildByName("icon_1") as class_1741;
         if(param1)
         {
            if(!var_323)
            {
               _loc2_.visible = false;
               _loc3_.visible = true;
               var_323 = new Timer(500,0);
               var_323.addEventListener("timer",onTimerEvent);
               var_323.start();
            }
         }
         else
         {
            if(var_323 != null)
            {
               var_323.removeEventListener("timer",onTimerEvent);
               var_323.stop();
               var_323 = null;
            }
            _loc2_.visible = true;
            _loc3_.visible = false;
            (var_422.getChildByName("icon_2") as class_1741).visible = false;
         }
      }
      
      private function onNewInstantMessage(param1:NewMessageEvent) : void
      {
         if(param1.notify)
         {
            _notifyMessengerOnStartup = true;
         }
         if(var_422)
         {
            if(param1.notify)
            {
               notifyMessenger(true);
            }
            else
            {
               var_422.visible = true;
               notifyMessenger(false);
            }
         }
         if(var_5183)
         {
            if(param1.notify)
            {
               var_5183.window.visible = true;
            }
         }
      }
      
      private function onFriendNotification(param1:NotificationEvent) : void
      {
         var _loc2_:FriendEntityTab = getFriendEntityTabByID(param1.friendId);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.addNotificationToken(param1.notification);
      }
      
      private function onRefreshMessengerConversations(param1:ActiveConversationsCountEvent) : void
      {
         if(var_422 != null)
         {
            var_422.visible = param1.activeConversationsCount != 0;
            notifyMessenger(param1.hasUnread);
         }
      }
      
      private function onSessionDataPreferences(param1:SessionDataPreferencesEvent) : void
      {
         if(!(param1.uiFlags & 1))
         {
            if(!var_1023)
            {
               toggleCollapsedState();
            }
         }
      }
      
      private function barWindowEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN")
         {
            _loc4_ = var_369;
            _loc3_ = _friendBarData.numFriends + (var_3687 ? 1 : 0) + (_friendBarData.numFriendRequests > 0 ? 1 : 0);
            switch(param2.name)
            {
               case "button_left":
                  _loc4_ = Math.max(0,var_369 - 1);
                  break;
               case "button_left_page":
                  _loc4_ = Math.max(0,var_369 - maxNumOfTabsVisible);
                  break;
               case "button_left_end":
                  _loc4_ = 0;
                  break;
               case "button_right":
                  _loc4_ = Math.max(0,Math.min(_loc3_ - maxNumOfTabsVisible,var_369 + 1));
                  break;
               case "button_right_page":
                  _loc4_ = Math.max(0,Math.min(_loc3_ - maxNumOfTabsVisible,var_369 + maxNumOfTabsVisible));
                  break;
               case "button_right_end":
                  _loc4_ = Math.max(0,_loc3_ - maxNumOfTabsVisible);
                  break;
               case "button_close":
                  visible = false;
                  break;
               case "border":
                  deSelect(true);
                  break;
               case "link_friendlist":
                  _friendBarData.toggleFriendList();
            }
            if(_loc4_ != var_369)
            {
               deSelect(true);
               var_369 = _loc4_;
               resizeAndPopulate(true);
            }
         }
         if(param1.type == "WE_DEACTIVATED")
         {
            deSelect(true);
         }
      }
      
      private function setCollapseButtonVisibility() : void
      {
         if(var_2403)
         {
            var_2403.visible = var_1023;
         }
         if(var_2256)
         {
            var_2256.visible = !var_1023;
         }
      }
      
      private function onCollapseFriendList(param1:WindowMouseEvent) : void
      {
         toggleCollapsedState();
      }
      
      private function toggleCollapsedState() : void
      {
         var_1023 = !var_1023;
         _sessionDataManager.setFriendBarState(!var_1023);
         deSelect(true);
         resizeAndPopulate(true);
         setCollapseButtonVisibility();
         if(!var_1023)
         {
            resizeAndPopulate(true);
         }
         var _loc1_:FriendBarResizeEvent = new FriendBarResizeEvent();
         events.dispatchEvent(_loc1_);
      }
      
      private function onOpenMessenger(param1:WindowMouseEvent) : void
      {
         _friendBarData.toggleMessenger();
         notifyMessenger(false);
      }
      
      private function onOpenFriendsList(param1:WindowMouseEvent) : void
      {
         _friendBarData.toggleFriendList();
      }
      
      private function onOpenSearchFriends(param1:WindowMouseEvent) : void
      {
         _friendBarData.openUserTextSearch();
      }
      
      public function removeMessengerNotifications() : void
      {
         for each(var _loc1_ in var_86)
         {
            if(_loc1_ is FriendEntityTab)
            {
               FriendEntityTab(_loc1_).removeNotificationToken(-1,true);
            }
         }
      }
      
      public function updateFriendRequestCounter(param1:int) : void
      {
         var _loc2_:IRegionWindow = null;
         if(!var_534)
         {
            var_534 = _windowManager.createUnseenItemCounter();
         }
         if(var_534)
         {
            _loc2_ = var_40.findChildByName("icon_all_friends") as IRegionWindow;
            if(_loc2_)
            {
               _loc2_.addChild(var_534);
               var_534.x = _loc2_.width - var_534.width - 5;
               var_534.y = 0;
               if(param1 > 0)
               {
                  var_534.visible = true;
                  var_534.findChildByName("count").caption = param1.toString();
               }
               else
               {
                  var_534.visible = false;
               }
            }
         }
      }
      
      private function toggleWindowEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(var_368.visible)
         {
            if(param1.type == "WME_DOWN")
            {
               var _loc3_:* = param2.name;
               if("button_open" === _loc3_)
               {
                  visible = true;
               }
            }
         }
      }
      
      private function toggleArrowButtons(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:IRegionWindow = var_40.findChildByName("button_left_page") as IRegionWindow;
         var _loc5_:IRegionWindow = var_40.findChildByName("button_right_page") as IRegionWindow;
         if(_loc4_ != null)
         {
            _loc4_.visible = param1;
            if(param2)
            {
               _loc4_.enable();
               _loc4_.blend = 1;
            }
            else
            {
               _loc4_.disable();
               _loc4_.blend = 0.2;
            }
         }
         if(_loc5_ != null)
         {
            _loc5_.visible = param1;
            if(param3)
            {
               _loc5_.enable();
               _loc5_.blend = 1;
            }
            else
            {
               _loc5_.disable();
               _loc5_.blend = 0.2;
            }
         }
         arrangeWindows();
      }
      
      private function resizeAndPopulate(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:int = 0;
         if(!disposed)
         {
            if(var_40)
            {
               _loc2_ = _toolbar.getRect();
               var_40.width = var_40.parent.width - _loc2_.right;
               var_2439.visible = !var_1023;
               if(!param1)
               {
                  _loc3_ = maxNumOfTabsVisible;
                  if(_loc3_ < var_86.length)
                  {
                     param1 = true;
                  }
                  else if(_loc3_ > var_86.length)
                  {
                     if(var_86.length < 3)
                     {
                        param1 = true;
                     }
                     else if(var_86.length < _friendBarData.numFriends + (var_3687 ? 1 : 0))
                     {
                        param1 = true;
                     }
                     else if(numFriendEntityTabsVisible < _friendBarData.numFriends)
                     {
                        param1 = true;
                     }
                  }
               }
               if(param1)
               {
                  populate();
                  arrangeWindows();
               }
               if(var_1023)
               {
                  var_40.x = var_40.desktop.width - 150;
               }
               else
               {
                  var_40.x = var_40.desktop.width - var_40.width;
                  var_2439.x = 1;
               }
            }
         }
      }
      
      private function arrangeWindows() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in var_40.iterator)
         {
            if(_loc2_.visible)
            {
               _loc2_.x = _loc1_;
               _loc1_ += _loc2_.width;
            }
         }
         var_40.width = _loc1_;
      }
      
      private function get numFriendEntityTabsVisible() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(var_86.length);
         while(_loc3_-- > 0)
         {
            if(var_86[_loc3_] is FriendEntityTab)
            {
               _loc2_++;
            }
         }
         var _loc1_:int = int(var_86.length);
         while(_loc1_-- > 0)
         {
            if(var_86[_loc1_] is FriendEntityTab)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      private function get maxNumOfTabsVisible() : int
      {
         var _loc1_:IItemListWindow = var_40.findChildByName("list") as IItemListWindow;
         var _loc2_:class_1812 = var_40.findChildByName("friendtools") as class_1812;
         return int((var_40.width - _loc2_.width - 16) / (127 + _loc1_.spacing));
      }
      
      private function onDesktopResized(param1:class_1758) : void
      {
         resizeAndPopulate(true);
      }
      
      public function get linkPattern() : String
      {
         return "friendbar/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         switch(_loc2_[1])
         {
            case "findfriends":
               _friendBarData.findNewFriends();
               break;
            case "user":
               if(_loc2_.length > 2)
               {
                  _friendBarData.showProfileByName(_loc2_[2]);
               }
               break;
            default:
               class_21.log("HabboFriendBarView unknown link-type received: " + _loc2_[1]);
         }
      }
   }
}

