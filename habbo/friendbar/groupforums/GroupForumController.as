package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import package_138.class_2525;
   import package_138.class_2547;
   import package_138.class_2601;
   import package_138.class_2605;
   import package_138.class_2830;
   import package_138.class_2923;
   import package_138.class_2998;
   import package_138.class_3215;
   import package_138.class_3481;
   import package_155.class_2670;
   import package_155.class_2720;
   import package_155.class_3177;
   import package_155.class_3294;
   import package_155.class_3297;
   import package_155.class_3361;
   import package_155.class_3434;
   import package_155.class_3497;
   import package_155.class_3590;
   import package_155.class_3591;
   import package_155.class_3652;
   import package_9.class_1879;
   import package_92.class_2341;
   import package_92.class_2366;
   import package_92.class_2800;
   import package_92.class_2886;
   import package_92.class_2918;
   import package_92.class_2984;
   import package_92.class_3030;
   import package_92.class_3128;
   import package_92.class_3390;
   import package_92.class_3498;
   import package_92.class_3515;
   import package_92.class_3542;
   
   public class GroupForumController extends class_17 implements class_2221, ILinkEventTracker
   {
      
      public static const FORUMS_LIST_CODE_ACTIVE:int = 0;
      
      public static const FORUMS_LIST_CODE_POPULAR:int = 1;
      
      public static const FORUMS_LIST_CODE_MY_FORUMS:int = 2;
      
      public static const NO_ID:int = -1;
      
      private var _configurationManager:class_16;
      
      private var _communicationManager:class_57;
      
      private var _windowManager:class_38;
      
      private var _localizationManager:class_27;
      
      private var _help:IHabboHelp;
      
      private var _notifications:class_536;
      
      private var _soundManager:class_544;
      
      private var _habboTracking:class_53;
      
      private var var_172:GroupForumView;
      
      private var var_2030:ComposeMessageView;
      
      private var var_4904:ForumSettingsView;
      
      private var var_1886:int = -1;
      
      private var var_1357:int = -1;
      
      private var var_95:class_3591;
      
      private var var_1833:int;
      
      private var var_519:int = 0;
      
      private var var_410:ForumsListData;
      
      private var var_830:ThreadsListData;
      
      private var var_1459:MessagesListData;
      
      private var _lastReadMessageIndexByThread:Dictionary = new Dictionary();
      
      private var var_3140:int = -1;
      
      private var var_3309:int;
      
      private var _lastPostTime:int = -30000;
      
      private var var_3335:int = 0;
      
      private var var_1517:Timer;
      
      public function GroupForumController(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      public function get composeMessageView() : ComposeMessageView
      {
         return var_2030;
      }
      
      public function set composeMessageView(param1:ComposeMessageView) : void
      {
         var_2030 = param1;
      }
      
      public function get forumSettingsView() : ForumSettingsView
      {
         return var_4904;
      }
      
      public function set forumSettingsView(param1:ForumSettingsView) : void
      {
         var_4904 = param1;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get lastPostTime() : int
      {
         return _lastPostTime;
      }
      
      public function get unreadForumsCount() : int
      {
         return var_3335;
      }
      
      public function get tracking() : class_53
      {
         return _habboTracking;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:class_16):void
         {
            _configurationManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _help = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),null)]);
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new class_2525(onThreadMessageList));
         _communicationManager.addHabboConnectionMessageEvent(new class_2998(onUnreadForumsCountMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_2547(onUpdateThread));
         _communicationManager.addHabboConnectionMessageEvent(new class_3481(onPostMessageMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_3215(onPostThreadMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_2830(onForumData));
         _communicationManager.addHabboConnectionMessageEvent(new class_2605(onForumsList));
         _communicationManager.addHabboConnectionMessageEvent(new class_2923(onThreadList));
         _communicationManager.addHabboConnectionMessageEvent(new class_2601(onUpdateMessage));
         context.addLinkEventTracker(this);
         startPollingForUnreadForumsCount();
      }
      
      override public function dispose() : void
      {
         if(var_1517 != null)
         {
            var_1517.stop();
            var_1517 = null;
         }
         super.dispose();
      }
      
      private function startPollingForUnreadForumsCount() : void
      {
         var _loc1_:int = _configurationManager.getInteger("groupforum.poll.period",300);
         var_1517 = new Timer(_loc1_ * 1000,0);
         var_1517.addEventListener("timer",onUnreadForumsCountUpdateTimerEvent);
         var_1517.start();
         onUnreadForumsCountUpdateTimerEvent(null);
      }
      
      public function openGroupForum(param1:int) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         initForum(param1);
         requestThreadList(param1,0);
      }
      
      public function get linkPattern() : String
      {
         return "groupforum/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!_communicationManager)
         {
            return;
         }
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 2)
         {
            return;
         }
         if(_loc3_[1] == "list")
         {
            if(_loc3_.length == 3)
            {
               switch(_loc3_[2])
               {
                  case "active":
                     _loc5_ = 0;
                     break;
                  case "popular":
                     _loc5_ = 1;
                     break;
                  case "my":
                     _loc5_ = 2;
                     break;
                  default:
                     return;
               }
               openForumsList(_loc5_);
            }
         }
         else
         {
            _loc6_ = int(_loc3_[1]);
            if(_loc6_ == 0)
            {
               return;
            }
            var_410 = null;
            if(_loc3_.length == 2)
            {
               openGroupForum(_loc6_);
            }
            else
            {
               var _loc2_:int = int(_loc3_[2]);
               var _loc4_:int = 0;
               if(_loc3_.length > 3)
               {
                  _loc4_ = int(_loc3_[3]);
               }
               initForum(_loc6_);
               _communicationManager.connection.send(new class_3390(_loc6_,0));
               goToMessageIndex(_loc6_,0,0);
            }
         }
      }
      
      public function openForumsList(param1:int, param2:int = 0) : void
      {
         markForumAsRead();
         var_1886 = param1;
         var_1357 = -1;
         _communicationManager.connection.send(new class_2886(param1,param2,20));
      }
      
      private function onForumsList(param1:class_2605) : void
      {
         var _loc3_:class_3497 = param1.getParser();
         var _loc2_:ForumsListData = new ForumsListData(_loc3_);
         if(var_95 != null && var_519 > 0)
         {
            _loc2_.updateUnreadMessages(var_95,var_519);
         }
         if(_loc2_.listCode == 2)
         {
            updateUnreadForumsCount(_loc2_.unreadForumsCount);
         }
         if(var_1886 != _loc2_.listCode)
         {
            return;
         }
         var_410 = _loc2_;
         if(!var_172)
         {
            var_172 = new GroupForumView(this);
         }
         var_172.openForumsList(var_410);
      }
      
      private function initForum(param1:int) : void
      {
         markForumAsRead();
         var_1886 = -1;
         var_1357 = param1;
         var_519 = 0;
         _communicationManager.connection.send(new class_3498(param1));
      }
      
      private function onForumData(param1:class_2830) : void
      {
         var _loc4_:class_3591 = param1.getParser().forumData;
         if(var_1357 != _loc4_.groupId)
         {
            return;
         }
         if(!_loc4_.canRead)
         {
            if(var_172 != null)
            {
               var_172.dispose();
            }
            var_95 = null;
            var_1357 = 0;
            var _loc2_:class_55 = new class_55();
            var _loc3_:String = localizationManager.getLocalization("groupforum.view.error.operation_read");
            null.add("message",localizationManager.getLocalizationWithParams("groupforum.view.error." + _loc4_.readPermissionError,"","operation",null));
            notifications.showNotification("forums.error.access_denied",null);
            return;
         }
         var_95 = _loc4_;
         var_519 = _loc4_.lastReadMessageId;
      }
      
      public function requestThreadList(param1:int, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_2341(param1,param2,20));
         }
      }
      
      private function onThreadList(param1:class_2923) : void
      {
         var _loc2_:class_3177 = param1.getParser();
         if(var_95 == null || var_95.groupId != _loc2_.groupId)
         {
            return;
         }
         var_830 = new ThreadsListData(var_95.totalThreads,_loc2_.startIndex,_loc2_.threads);
         if(!var_172)
         {
            var_172 = new GroupForumView(this);
         }
         var_172.openThreadList(var_410,var_95,var_830);
      }
      
      public function requestThreadMessageList(param1:int, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_3515(param1,param2,param3,20));
         }
      }
      
      private function onThreadMessageList(param1:class_2525) : void
      {
         var _loc3_:class_3361 = param1.getParser();
         if(var_95 == null || var_95.groupId != _loc3_.groupId || var_830 == null)
         {
            return;
         }
         var_1833 = _loc3_.threadId;
         var _loc2_:class_3434 = var_830.threadsById[var_1833];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.startIndex;
         var _loc5_:int = _loc2_.nMessages;
         var_1459 = new MessagesListData(var_1833,_loc5_,_loc4_,_loc3_.messages);
         if(!var_172)
         {
            var_172 = new GroupForumView(this);
         }
         var_172.openMessagesList(var_410,var_95,var_830,var_1459);
         if(_loc3_.messages.length > 0)
         {
            var _loc6_:class_2670 = class_2670(_loc3_.messages[_loc3_.messages.length - 1]);
            if(_loc6_)
            {
               updateUnreadMessageCounts(null.messageId,null.threadId,null.messageIndex);
            }
         }
      }
      
      public function updateForumSettings(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_3128(param1,param2,param3,param4,param5));
         }
      }
      
      public function postNewThread(param1:int, param2:String, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_2800(param1,0,param2,param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostThreadMessage(param1:class_3215) : void
      {
         var _loc3_:class_3590 = null;
         var _loc2_:class_3294 = class_3294(param1.getParser());
         if(var_2030)
         {
            var_2030.dispose();
         }
         if(var_95 != null && var_95.groupId == _loc2_.groupId)
         {
            updateUnreadMessageCounts(_loc2_.thread.lastMessageId,_loc2_.thread.threadId,_loc2_.thread.nMessages - 1);
         }
         if(var_410 != null)
         {
            _loc3_ = var_410.getForumData(_loc2_.groupId);
            if(_loc3_ != null)
            {
               _loc3_.addNewThread(_loc2_.thread);
            }
         }
         if(var_172 == null)
         {
            return;
         }
         if(var_95 == null || _loc2_.groupId != var_95.groupId)
         {
            return;
         }
         requestThreadList(var_95.groupId,0);
      }
      
      public function postNewMessage(param1:int, param2:int, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_2800(param1,param2,"",param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostMessageMessage(param1:class_3481) : void
      {
         if(var_2030)
         {
            var_2030.dispose();
         }
         if(var_172 == null)
         {
            return;
         }
         var _loc2_:class_3297 = class_3297(param1.getParser());
         if(var_95 == null || _loc2_.groupId != var_95.groupId || _loc2_.threadId != var_1833)
         {
            return;
         }
         var _loc3_:int = _loc2_.message.messageIndex - _loc2_.message.messageIndex % 20;
         requestThreadMessageList(var_95.groupId,var_1833,_loc3_);
      }
      
      public function deleteThread(param1:class_3591, param2:int) : void
      {
         var _loc3_:int = 0;
         if(_communicationManager)
         {
            if(param1.canModerate)
            {
               _loc3_ = 10;
            }
            if(param1.isStaff)
            {
               _loc3_ = 20;
            }
            _communicationManager.connection.send(new class_3542(param1.groupId,param2,_loc3_));
         }
      }
      
      public function unDeleteThread(param1:class_3590, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_3542(param1.groupId,param2,1));
         }
      }
      
      public function lockThread(param1:class_3590, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_2918(param1.groupId,param2,param3,param4));
         }
      }
      
      public function stickThread(param1:class_3590, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_2918(param1.groupId,param2,param3,param4));
         }
      }
      
      public function reportThread(param1:class_3590, param2:int) : void
      {
         if(_help)
         {
            _help.reportThread(param1.groupId,param2);
         }
      }
      
      private function onUpdateThread(param1:class_2547) : void
      {
         var _loc2_:class_2720 = param1.getParser();
         if(var_95 == null || var_95.groupId != _loc2_.groupId)
         {
            return;
         }
         var _loc3_:class_3434 = _loc2_.thread;
         if(var_830 && var_172)
         {
            if(var_830.updateThread(_loc3_))
            {
               var_172.updateThread(_loc3_);
               return;
            }
         }
         var_830 = new ThreadsListData(1,0,[_loc3_]);
      }
      
      public function deleteMessage(param1:class_3591, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         if(_communicationManager)
         {
            _loc4_ = 10;
            if(param1.isStaff)
            {
               _loc4_ = 20;
            }
            _communicationManager.connection.send(new class_3030(var_95.groupId,param2,param3,_loc4_));
         }
      }
      
      public function unDeleteMessage(param1:class_3590, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_3030(param1.groupId,param2,param3,1));
         }
      }
      
      public function reportMessage(param1:class_3590, param2:int, param3:int) : void
      {
         if(_help)
         {
            _help.reportMessage(param1.groupId,param2,param3);
         }
      }
      
      private function onUpdateMessage(param1:class_2601) : void
      {
         var _loc5_:int = 0;
         var _loc6_:class_2670 = null;
         var _loc3_:class_3652 = param1.getParser();
         if(var_95 == null || var_95.groupId != _loc3_.groupId || var_1833 != _loc3_.threadId)
         {
            return;
         }
         var _loc2_:class_2670 = _loc3_.message;
         var _loc4_:Array = var_1459["messages"];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            if(_loc6_.messageId == _loc2_.messageId)
            {
               _loc4_[_loc5_] = _loc2_;
               if(var_172)
               {
                  var_172.updateMessage(_loc2_);
               }
               return;
            }
            _loc5_++;
         }
      }
      
      public function goToMessageIndex(param1:int, param2:int, param3:int) : void
      {
         var_3140 = param2;
         var _loc4_:int = Math.floor(param3 / 20);
         var_3309 = param3 % 20;
         requestThreadMessageList(param1,param2,_loc4_ * 20);
      }
      
      public function getUserInfo(param1:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_1879(param1));
         }
      }
      
      public function closeMainView() : void
      {
         markForumAsRead();
         var_172 = null;
         var_95 = null;
         var_1886 = -1;
         var_1357 = -1;
      }
      
      public function markForumAsRead(param1:Boolean = false) : void
      {
         var _loc2_:class_2984 = null;
         if(_communicationManager && var_95)
         {
            if(param1 || var_519 > var_95.lastReadMessageId)
            {
               _loc2_ = new class_2984();
               if(param1)
               {
                  _loc2_.add(var_95.groupId,Math.max(var_95.totalMessages,var_519),var_519 == 0);
               }
               else
               {
                  _loc2_.add(var_95.groupId,var_519,false);
               }
               _communicationManager.connection.send(_loc2_);
            }
         }
         var_519 = 0;
         _lastReadMessageIndexByThread = new Dictionary();
      }
      
      public function markForumsAsRead() : void
      {
         var _loc1_:class_2984 = null;
         if(_communicationManager && var_410)
         {
            _loc1_ = new class_2984();
            for each(var _loc2_ in var_410.forums)
            {
               if(_loc2_.unreadMessages > 0)
               {
                  _loc1_.add(_loc2_.groupId,_loc2_.totalMessages,true);
               }
            }
            if(_loc1_.size > 0)
            {
               _communicationManager.connection.send(_loc1_);
               updateUnreadForumsCount(0);
            }
         }
      }
      
      public function getThreadLastReadMessageIndex(param1:int) : int
      {
         var _loc2_:* = _lastReadMessageIndexByThread[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         if(var_830)
         {
            var _loc3_:class_3434 = var_830.threadsById[param1];
         }
         return -1;
      }
      
      public function updateUnreadMessageCounts(param1:int, param2:int, param3:int) : void
      {
         if(param1 > var_519)
         {
            var_519 = param1;
            if(var_410)
            {
               var_410.updateUnreadMessages(var_95,param1);
               if(var_410.listCode == 2)
               {
                  updateUnreadForumsCount(var_410.unreadForumsCount);
               }
            }
         }
         _lastReadMessageIndexByThread[param2] = param3;
      }
      
      public function getGoToMessageIndex() : int
      {
         return var_3309;
      }
      
      public function getGoToThreadId() : int
      {
         return var_3140;
      }
      
      public function resetGoTo() : void
      {
         var_3140 = -1;
         var_3309 = -1;
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(var_3335 == param1)
         {
            return;
         }
         if(param1 > var_3335)
         {
            if(_soundManager != null)
            {
            }
         }
         var_3335 = param1;
         events.dispatchEvent(new UnseenForumsCountUpdatedEvent("UNSEEN_FORUMS_COUNT",param1));
         if(var_172 != null)
         {
            var_172.updateUnreadForumsCount(param1);
         }
      }
      
      private function onUnreadForumsCountUpdateTimerEvent(param1:TimerEvent) : void
      {
         if(var_172 != null)
         {
            _communicationManager.connection.send(new class_2886(2,0,20));
         }
         else
         {
            _communicationManager.connection.send(new class_2366());
         }
      }
      
      private function onUnreadForumsCountMessage(param1:class_2998) : void
      {
         updateUnreadForumsCount(param1.getParser().unreadForumsCount);
      }
   }
}

