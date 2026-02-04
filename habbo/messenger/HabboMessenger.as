package com.sulake.habbo.messenger
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendlist.class_1927;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.events.ActiveConversationEvent;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import package_11.class_1825;
   import package_11.class_1938;
   import package_11.class_2025;
   import package_11.class_2027;
   import package_11.class_2137;
   import package_14.class_1792;
   import package_14.class_1870;
   import package_14.class_1955;
   import package_14.class_2002;
   import package_14.class_2028;
   import package_14.class_2090;
   import package_14.class_2096;
   import package_27.class_1809;
   import package_3.class_2123;
   import package_72.class_2203;
   
   public class HabboMessenger extends class_17 implements class_46, ILinkEventTracker
   {
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _localization:class_27;
      
      private var _friendList:class_258;
      
      private var _soundManager:class_544;
      
      private var _tracking:class_53;
      
      private var var_1768:int = 0;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _help:IHabboHelp;
      
      private var var_172:MainView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2896:Boolean = false;
      
      private var _followingToGroupRoom:Boolean = false;
      
      public function HabboMessenger(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _help = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_2096(onMessengerInit));
         addMessageEvent(new class_1809(onAccountPreferences));
         addMessageEvent(new class_2123(onHabboGroupDetails));
         if(getBoolean("client.minimail.embed.enabled"))
         {
            addMessageEvent(new class_2090(onMiniMailMessage));
            addMessageEvent(new class_1870(onMiniMailUnreadCount));
         }
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         super.dispose();
      }
      
      private function onMiniMailMessage(param1:IMessageEvent) : void
      {
         var_1768 = var_1768 + 1;
         playMessageReceivedSound();
         events.dispatchEvent(new MiniMailMessageEvent("MMME_new",var_1768));
      }
      
      private function onMiniMailUnreadCount(param1:IMessageEvent) : void
      {
         var_1768 = (param1.parser as class_1938).unreadMessageCount;
         events.dispatchEvent(new MiniMailMessageEvent("MMME_unread",var_1768));
      }
      
      private function onAccountPreferences(param1:class_1809) : void
      {
         var_2896 = param1.getParser().roomInvitesIgnored;
      }
      
      private function onHabboGroupDetails(param1:class_2123) : void
      {
         if(_followingToGroupRoom)
         {
            _followingToGroupRoom = false;
            send(new class_2203(param1.data.roomId));
         }
      }
      
      public function getRoomInvitesIgnored() : Boolean
      {
         return var_2896;
      }
      
      public function setRoomInvitesIgnored(param1:Boolean) : void
      {
         var_2896 = param1;
      }
      
      private function onMessengerInit(param1:IMessageEvent) : void
      {
         var_172 = new MainView(this);
         addMessageEvent(new class_2028(onNewConsoleMessage));
         addMessageEvent(new class_2002(onConsoleHistory));
         addMessageEvent(new class_1955(onInstantMessageError));
         addMessageEvent(new class_1792(onRoomInvite));
      }
      
      public function startConversation(param1:int) : void
      {
         if(var_172 != null)
         {
            var_172.startConversation(param1);
            var_172.show(true);
         }
      }
      
      public function getUnseenMiniMailMessageCount() : int
      {
         return var_1768;
      }
      
      public function setFollowingAllowed(param1:int, param2:Boolean) : void
      {
         if(var_172 != null)
         {
            var_172.setFollowingAllowed(param1,param2);
         }
      }
      
      public function setOnlineStatus(param1:int, param2:Boolean) : void
      {
         if(var_172 != null)
         {
            var_172.setOnlineStatus(param1,param2);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function playSendSound() : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound("HBST_message_sent");
         }
      }
      
      public function isOpen() : Boolean
      {
         return var_172 != null && var_172.isOpen;
      }
      
      public function toggleMessenger() : void
      {
         if(var_172 != null)
         {
            var_172.toggle();
         }
      }
      
      public function getText(param1:String) : String
      {
         return _localization.getLocalization(param1,param1);
      }
      
      private function onNewConsoleMessage(param1:class_2028) : void
      {
         var _loc2_:class_2137 = param1.getParser();
         class_21.log("Received console msg: " + _loc2_.messageText + ", " + _loc2_.chatId);
         if(var_172 != null)
         {
            var_172.addConsoleMessage(_loc2_.chatId,_loc2_.messageText,_loc2_.secondsSinceSent,_loc2_.messageId,_loc2_.confirmationId,_loc2_.senderId,_loc2_.senderName,_loc2_.senderFigure);
            if(!var_172.isOpen)
            {
               playMessageReceivedSound();
            }
         }
      }
      
      private function onConsoleHistory(param1:class_2002) : void
      {
         var _loc2_:class_2027 = param1.getParser();
         if(var_172 != null)
         {
            var_172.loadMessageHistory(_loc2_.chatId,_loc2_.historyFragment);
         }
      }
      
      private function onRoomInvite(param1:class_1792) : void
      {
         var _loc2_:class_1825 = param1.getParser();
         if(var_172 != null)
         {
            var_172.addRoomInvite(_loc2_.senderId,_loc2_.messageText);
            if(!var_172.isOpen)
            {
               playMessageReceivedSound();
            }
         }
      }
      
      private function playMessageReceivedSound() : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound("HBST_message_received");
         }
      }
      
      private function onInstantMessageError(param1:IMessageEvent) : void
      {
         var _loc2_:class_2025 = (param1 as class_1955).getParser();
         if(var_172 != null)
         {
            var_172.onInstantMessageError(_loc2_.userId,_loc2_.errorCode,_loc2_.message);
         }
      }
      
      public function conversationCountUpdated(param1:int, param2:Boolean) : void
      {
         events.dispatchEvent(new ActiveConversationEvent("ACCE_changed",param1,param2));
      }
      
      public function getXmlWindow(param1:String) : class_1741
      {
         var _loc3_:IAsset = assets.getAssetByName(param1 + "_xml");
         var _loc2_:XmlAsset = XmlAsset(_loc3_);
         return _windowManager.buildFromXML(XML(_loc2_.content));
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      internal function getFriend(param1:int, param2:ChatEntry = null) : class_1927
      {
         var _loc3_:class_1927 = _friendList.getFriend(param1);
         if(_loc3_ == null && param2 != null)
         {
            return new DummyFriend(param2.senderId,param2.senderName,param2.senderFigure);
         }
         return _loc3_;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      internal function reportUser(param1:int) : void
      {
         _help.reportUserFromIM(param1);
      }
      
      public function set followingToGroupRoom(param1:Boolean) : void
      {
         _followingToGroupRoom = param1;
      }
      
      public function closeConversation(param1:int) : void
      {
         var_172.hideConversation(param1);
      }
      
      public function get linkPattern() : String
      {
         return "messenger/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[1]);
         startConversation(_loc3_);
      }
   }
}

