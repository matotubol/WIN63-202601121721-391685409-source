package com.sulake.habbo.friendbar.data
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
   import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
   import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
   import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
   import com.sulake.habbo.friendbar.events.NewMessageEvent;
   import com.sulake.habbo.friendbar.events.NotificationEvent;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.messenger.events.ActiveConversationEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteEventParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateEventParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationEventParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2083;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_2254;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
   
   public class HabboFriendBarData extends class_17 implements class_1813
   {
      
      private static const SHOW_OFFLINE_FRIENDS:Boolean = false;
      
      private static const SORT_ALPHABETICALLY:Boolean = false;
      
      private static const TRACKING_EVENT_CATEGORY:String = "Navigation";
      
      private static const TRACKING_EVENT_TYPE:String = "Friend Bar";
      
      private static const TRACKING_EVENT_ACTION_VISIT:String = "go.friendbar";
      
      private static const TRACKING_EVENT_ACTION_CHAT:String = "chat_btn_click";
      
      private static const TRACKING_EVENT_ACTION_FIND_FRIENDS:String = "find_friends_btn_click";
      
      public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_TAB:String = "play_snowstorm_tab_click";
      
      public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_BUTTON:String = "play_snowstorm_btn_click";
      
      private static const const_1160:String = "Toolbar";
      
      private static const const_208:String = "open";
      
      private static const const_728:String = "close";
      
      private static const LEGACY_TRACKING_EVENT_TYPE_FRIENDLIST:String = "FRIENDLIST";
      
      private static const LEGACY_TRACKING_EVENT_TYPE_MESSENGER:String = "MESSENGER";
      
      private var _habboCommunicationManager:class_57;
      
      private var _habboFriendListComponent:class_258;
      
      private var _habboMessengerComponent:class_46;
      
      private var _tracking:class_53;
      
      private var var_171:Array;
      
      private var var_577:class_55;
      
      private var var_193:Array;
      
      private var var_1735:int;
      
      public function HabboFriendBarData(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_171 = [];
         var_577 = new class_55();
         var_193 = [];
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _habboCommunicationManager = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _habboFriendListComponent = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:class_46):void
         {
            _habboMessengerComponent = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _habboCommunicationManager.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInitialized));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequestList));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(onFindFriendProcessResult));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new RoomInviteEvent(onRoomInvite));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendNotificationEvent(onFriendNotification));
         _habboFriendListComponent.events.addEventListener("FRE_ACCEPTED",onFriendRequestEvent);
         _habboFriendListComponent.events.addEventListener("FRE_DECLINED",onFriendRequestEvent);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_habboFriendListComponent != null && !_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.events.removeEventListener("FRE_ACCEPTED",onFriendRequestEvent);
               _habboFriendListComponent.events.removeEventListener("FRE_DECLINED",onFriendRequestEvent);
            }
            var_171 = null;
            var_577.dispose();
            var_577 = null;
            var_193 = null;
            super.dispose();
         }
      }
      
      public function get numFriends() : int
      {
         return var_171.length;
      }
      
      public function getFriendAt(param1:int) : class_3462
      {
         return var_171[param1];
      }
      
      public function getFriendByID(param1:int) : class_3462
      {
         return var_577.getValue(param1);
      }
      
      public function getFriendByName(param1:String) : class_3462
      {
         for each(var _loc2_ in var_171)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setFriendAt(param1:class_3462, param2:int) : void
      {
         var _loc3_:int = int(var_171.indexOf(param1));
         if(_loc3_ > -1 && _loc3_ != param2)
         {
            var_171.splice(_loc3_,1);
            var_171.splice(param2,0,param1);
            events.dispatchEvent(new FriendBarUpdateEvent());
         }
      }
      
      public function get numFriendRequests() : int
      {
         return var_193 ? var_193.length : 0;
      }
      
      public function getFriendRequestAt(param1:int) : class_3380
      {
         return var_193 ? var_193[param1] : null;
      }
      
      public function getFriendRequestByID(param1:int) : class_3380
      {
         if(var_193)
         {
            for each(var _loc2_ in var_193)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getFriendRequestByName(param1:String) : class_3380
      {
         if(var_193)
         {
            for each(var _loc2_ in var_193)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getFriendRequestList() : Array
      {
         return var_193;
      }
      
      public function acceptFriendRequest(param1:int) : void
      {
         removeFriendRequest(param1);
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.acceptFriendRequest(param1);
            }
         }
      }
      
      public function showProfile(param1:int) : void
      {
         if(_habboCommunicationManager)
         {
            if(param1 > 0)
            {
               _habboCommunicationManager.connection.send(new GetExtendedProfileMessageComposer(param1));
            }
            else
            {
               _habboCommunicationManager.connection.send(new GetHabboGroupDetailsMessageComposer(Math.abs(param1),true));
            }
         }
      }
      
      public function showProfileByName(param1:String) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new GetExtendedProfileByNameMessageComposer(param1));
         }
      }
      
      public function acceptAllFriendRequests() : void
      {
         var_193 = [];
         _habboFriendListComponent.acceptAllFriendRequests();
         events.dispatchEvent(new FriendRequestUpdateEvent());
      }
      
      public function declineFriendRequest(param1:int) : void
      {
         removeFriendRequest(param1);
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.declineFriendRequest(param1);
            }
         }
      }
      
      public function declineAllFriendRequests() : void
      {
         var_193 = [];
         _habboFriendListComponent.declineAllFriendRequests();
         events.dispatchEvent(new FriendRequestUpdateEvent());
      }
      
      private function removeFriendRequest(param1:int) : void
      {
         if(var_193)
         {
            for each(var _loc2_ in var_193)
            {
               if(_loc2_.id == param1)
               {
                  var_193.splice(var_193.indexOf(_loc2_),1);
                  events.dispatchEvent(new FriendRequestUpdateEvent());
                  return;
               }
            }
         }
      }
      
      public function followToRoom(param1:int) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new FollowFriendMessageComposer(param1));
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","go.friendbar"));
         }
      }
      
      public function startConversation(param1:int) : void
      {
         if(_habboMessengerComponent)
         {
            _habboMessengerComponent.startConversation(param1);
            events.dispatchEvent(new NewMessageEvent(false,param1));
            if(_habboCommunicationManager)
            {
               _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","chat_btn_click"));
            }
         }
      }
      
      public function findNewFriends() : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new FindNewFriendsMessageComposer());
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","find_friends_btn_click"));
         }
      }
      
      public function openUserTextSearch() : void
      {
         if(_habboFriendListComponent.currentTabId() != 3)
         {
            _habboFriendListComponent.openFriendSearch();
         }
         else
         {
            _habboFriendListComponent.close();
         }
      }
      
      public function sendGameTabTracking(param1:String) : void
      {
         sendEventLogTracking("play_snowstorm_tab_click",param1);
      }
      
      public function sendGameButtonTracking(param1:String) : void
      {
         sendEventLogTracking("play_snowstorm_btn_click",param1);
      }
      
      private function sendEventLogTracking(param1:String, param2:String) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar",param1,param2,numFriends));
         }
      }
      
      public function toggleFriendList() : void
      {
         var _loc1_:class_1812 = null;
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               if(!_habboFriendListComponent.isOpen())
               {
                  if(var_193.length > 0)
                  {
                     _habboFriendListComponent.openFriendRequests();
                  }
                  else
                  {
                     _habboFriendListComponent.openFriendList();
                  }
               }
               else
               {
                  _loc1_ = _habboFriendListComponent.mainWindow;
                  if(_loc1_ != null && WindowToggle.isHiddenByOtherWindows(_loc1_))
                  {
                     _loc1_.activate();
                     return;
                  }
                  _habboFriendListComponent.close();
               }
               if(_habboCommunicationManager)
               {
                  _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar","FRIENDLIST",_habboFriendListComponent.isOpen() ? "open" : "close"));
               }
            }
         }
      }
      
      public function toggleMessenger() : void
      {
         if(_habboMessengerComponent)
         {
            if(!_habboMessengerComponent.disposed)
            {
               _habboMessengerComponent.toggleMessenger();
               if(_habboCommunicationManager)
               {
                  _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar","MESSENGER",_habboMessengerComponent.isOpen() ? "open" : "close"));
               }
            }
         }
      }
      
      private function onMessengerInitialized(param1:IMessageEvent) : void
      {
         if(_habboMessengerComponent)
         {
            _habboMessengerComponent.events.addEventListener("ACCE_changed",onUpdateActiveConversationCount);
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         buildFriendList(FriendListFragmentMessageEvent(param1).getParser().friendFragment);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FriendEntity = null;
         var _loc6_:* = null;
         var _loc4_:FriendListUpdateEventParser = FriendListUpdateEvent(param1).getParser();
         var _loc3_:Array = _loc4_.removedFriendIds;
         var _loc8_:Array = _loc4_.updatedFriends;
         var _loc5_:Array = _loc4_.addedFriends;
         for each(var _loc7_ in _loc3_)
         {
            _loc2_ = var_577.getValue(_loc7_);
            if(_loc2_)
            {
               var_577.remove(_loc7_);
               var_171.splice(var_171.indexOf(_loc2_),1);
               _habboMessengerComponent.closeConversation(_loc7_);
            }
         }
         for each(_loc6_ in _loc8_)
         {
            _loc2_ = var_577.getValue(_loc6_.id);
            if(_loc2_)
            {
               if(_loc6_.online)
               {
                  _loc2_.name = _loc6_.name;
                  _loc2_.realName = _loc6_.realName;
                  _loc2_.motto = _loc6_.motto;
                  _loc2_.gender = _loc6_.gender;
                  _loc2_.online = _loc6_.online;
                  _loc2_.allowFollow = _loc6_.followingAllowed;
                  _loc2_.figure = _loc6_.figure;
                  _loc2_.categoryId = _loc6_.categoryId;
                  _loc2_.lastAccess = _loc6_.lastAccess;
               }
               else
               {
                  var_577.remove(_loc6_.id);
                  var_171.splice(var_171.indexOf(_loc2_),1);
               }
            }
            else if(_loc6_.online)
            {
               _loc2_ = new FriendEntity(_loc6_.id,_loc6_.name,_loc6_.realName,_loc6_.motto,_loc6_.gender,_loc6_.online,_loc6_.followingAllowed,_loc6_.figure,_loc6_.categoryId,_loc6_.lastAccess);
               var_171.splice(0,0,_loc2_);
               var_577.add(_loc2_.id,_loc2_);
            }
         }
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.online)
            {
               if(var_577.getValue(_loc6_.id) == null)
               {
                  _loc2_ = new FriendEntity(_loc6_.id,_loc6_.name,_loc6_.realName,_loc6_.motto,_loc6_.gender,_loc6_.online,_loc6_.followingAllowed,_loc6_.figure,_loc6_.categoryId,_loc6_.lastAccess);
                  var_171.push(_loc2_);
                  var_577.add(_loc2_.id,_loc2_);
               }
            }
            removeFriendRequest(_loc6_.id);
         }
         if(_loc5_.length > 0 || _loc8_.length > 0)
         {
            var_171 = sortByName(var_171);
         }
         events.dispatchEvent(new FriendBarUpdateEvent());
      }
      
      private function onFindFriendProcessResult(param1:FindFriendsProcessResultEvent) : void
      {
         events.dispatchEvent(new FindFriendsNotificationEvent(param1.success));
      }
      
      private function onNewFriendRequest(param1:NewFriendRequestEvent) : void
      {
         var _loc2_:class_2254 = null;
         if(showFriendRequests)
         {
            _loc2_ = param1.getParser().req;
            var_193.push(new FriendRequest(_loc2_.requestId,_loc2_.requesterName,_loc2_.figureString));
            events.dispatchEvent(new FriendRequestUpdateEvent());
         }
      }
      
      private function onFriendRequestList(param1:FriendRequestsEvent) : void
      {
         var _loc3_:Array = null;
         if(showFriendRequests)
         {
            _loc3_ = param1.getParser().reqs;
            for each(var _loc2_ in _loc3_)
            {
               var_193.push(new FriendRequest(_loc2_.requestId,_loc2_.requesterName,_loc2_.figureString));
            }
            events.dispatchEvent(new FriendRequestUpdateEvent());
         }
      }
      
      private function onFriendRequestEvent(param1:FriendRequestEvent) : void
      {
         removeFriendRequest(param1.requestId);
      }
      
      private function onNewConsoleMessage(param1:NewConsoleMessageEvent) : void
      {
         var _loc2_:NewConsoleMessageEventParser = param1.getParser();
         var_1735 = _loc2_.chatId;
         var _loc3_:Boolean = true;
         if(_habboMessengerComponent)
         {
            if(_habboMessengerComponent.isOpen())
            {
               _loc3_ = false;
            }
         }
         if(_habboFriendListComponent.hasfriendsListInitialized)
         {
            events.dispatchEvent(new NewMessageEvent(_loc3_,var_1735));
         }
         if(_loc3_)
         {
            makeNotification(String(var_1735),-1,null,false,false);
         }
      }
      
      private function onUpdateActiveConversationCount(param1:ActiveConversationEvent) : void
      {
         events.dispatchEvent(new ActiveConversationsCountEvent(param1.activeConversationsCount,param1.hasUnread));
      }
      
      private function onRoomInvite(param1:RoomInviteEvent) : void
      {
         var _loc2_:RoomInviteEventParser = param1.getParser();
         var_1735 = _loc2_.senderId;
         if(_habboMessengerComponent && !_habboMessengerComponent.isOpen())
         {
            events.dispatchEvent(new NewMessageEvent(true,var_1735));
            makeNotification(String(var_1735),-1,null,true,false);
         }
      }
      
      private function onFriendNotification(param1:FriendNotificationEvent) : void
      {
         var _loc4_:FriendNotificationEventParser = param1.getParser();
         var _loc2_:* = _loc4_.typeCode != 3;
         var _loc5_:* = _loc4_.typeCode != 4;
         var _loc3_:* = _loc4_.typeCode != 3;
         makeNotification(_loc4_.avatarId,_loc4_.typeCode,_loc4_.message,_loc2_,_loc5_,_loc3_);
      }
      
      private function makeNotification(param1:String, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean = true) : void
      {
         if(showFriendNotifications)
         {
            var _loc7_:class_3462 = getFriendByID(parseInt(param1));
            if(_loc7_)
            {
               var _loc9_:Vector.<class_2307> = null.notifications;
               for each(var _loc8_ in undefined)
               {
                  if(_loc8_.typeCode == param2)
                  {
                     null.message = param3;
                     null.viewOnce = param4;
                     break;
                  }
                  _loc8_ = null;
               }
               _loc8_ = new FriendNotification(param2,param3,param4);
               undefined.push(null);
               events.dispatchEvent(new NotificationEvent(null.id,null));
               if(param5)
               {
                  setFriendAt(null,0);
               }
               if(null.logEventId < 0)
               {
                  null.logEventId = null.getNextLogEventId();
               }
               if(_tracking)
               {
                  _tracking.trackEventLog("FriendBar",FriendNotification.typeCodeToString(param2),"notified","",null.logEventId > 0 ? null.logEventId : 0);
               }
            }
         }
      }
      
      private function buildFriendList(param1:Array) : void
      {
         var _loc2_:FriendEntity = null;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.online)
            {
               _loc2_ = new FriendEntity(_loc3_.id,_loc3_.name,_loc3_.realName,_loc3_.motto,_loc3_.gender,_loc3_.online,_loc3_.followingAllowed,_loc3_.figure,_loc3_.categoryId,_loc3_.lastAccess);
               var_171.push(_loc2_);
               var_577.add(_loc2_.id,_loc2_);
            }
         }
         var_171 = sortByName(var_171);
         events.dispatchEvent(new FriendBarUpdateEvent());
      }
      
      private function sortByName(param1:Array) : Array
      {
         return param1;
      }
      
      private function sortByNameAndOnlineStatus(param1:Array) : Array
      {
         var _loc5_:FriendEntity = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:int = int(param1.length);
         while(_loc4_-- > 0)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.online)
            {
               _loc2_.push(_loc5_);
            }
            else
            {
               _loc3_.push(_loc5_);
            }
         }
         _loc4_ = int(_loc3_.length);
         while(_loc4_-- > 0)
         {
            _loc2_.push(_loc3_.pop());
         }
         return _loc2_;
      }
      
      public function get showFriendNotifications() : Boolean
      {
         return getBoolean("friendbar.notifications.enabled");
      }
      
      public function get showFriendRequests() : Boolean
      {
         return getBoolean("friendbar.requests.enabled");
      }
   }
}

