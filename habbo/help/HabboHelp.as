package com.sulake.habbo.help
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
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.help.class_1878;
   import com.sulake.habbo.communication.messages.parser.help.class_1963;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.help.cfh.registry.chat.ChatEventHandler;
   import com.sulake.habbo.help.cfh.registry.chat.ChatRegistry;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageEventHandler;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistry;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistry;
   import com.sulake.habbo.help.namechange.NameChangeController;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import package_17.class_1781;
   import package_18.class_1782;
   import package_18.class_2041;
   import package_18.class_2165;
   import package_18.class_2218;
   import package_2.class_1736;
   import package_2.class_1786;
   import package_2.class_1979;
   import package_2.class_2195;
   import package_28.class_1824;
   import package_34.class_1850;
   import package_34.class_1991;
   import package_34.class_2008;
   import package_34.class_2181;
   import package_35.class_1854;
   import package_38.HumanGameObjectData;
   import package_39.class_1916;
   import package_39.class_1980;
   import package_39.class_2007;
   import package_40.class_1888;
   import package_42.class_2168;
   import package_50.class_1988;
   import package_50.class_1996;
   import package_53.class_2038;
   import package_54.class_2169;
   import package_56.class_2054;
   import package_57.class_2055;
   import package_9.class_1891;
   
   public class HabboHelp extends class_17 implements IHabboHelp, ILinkEventTracker
   {
      
      public static const REPORT_TYPE_EMERGENCY:int = 1;
      
      public static const REPORT_TYPE_GUIDE:int = 2;
      
      public static const REPORT_TYPE_IM:int = 3;
      
      public static const REPORT_TYPE_ROOM:int = 4;
      
      public static const REPORT_TYPE_BULLY:int = 6;
      
      public static const REPORT_TYPE_THREAD:int = 7;
      
      public static const REPORT_TYPE_MESSAGE:int = 8;
      
      public static const REPORT_TYPE_PHOTO:int = 9;
      
      private var _toolbar:IHabboToolbar;
      
      private var _windowManager:class_38;
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:class_41;
      
      private var _tracking:class_53;
      
      private var _soundManager:class_544;
      
      private var _friendList:class_258;
      
      private var _freeFlowChat:class_51;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_1973:ChatEventHandler;
      
      private var var_5186:InstantMessageEventHandler;
      
      private var var_619:GuideHelpManager;
      
      private var _userRegistry:UserRegistry = new UserRegistry();
      
      private var _chatRegistry:ChatRegistry = new ChatRegistry();
      
      private var _instantMessageRegistry:InstantMessageRegistry = new InstantMessageRegistry();
      
      private var var_1170:NameChangeController;
      
      private var var_42:CallForHelpManager;
      
      private var var_1005:WelcomeScreenController;
      
      private var var_1167:HabboWayController;
      
      private var var_560:HabboWayQuizController;
      
      private var var_1162:SafetyBookletController;
      
      private var _outsideRoom:Boolean;
      
      private var var_363:int;
      
      private var _reportMessage:IMessageComposer;
      
      private var var_1282:int = -1;
      
      private var var_19:int;
      
      private var var_1950:Vector.<class_2218>;
      
      private var var_522:TopicsFlowHelpController;
      
      private var _sanctionInfo:SanctionInfo;
      
      private var _reportStatus:MyReportStatus;
      
      public function HabboHelp(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
      }
      
      public function get localization() : class_27
      {
         return _localizationManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get tracking() : class_53
      {
         return _tracking;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get newUserTourEnabled() : Boolean
      {
         return getBoolean("guide.help.new.user.tour.enabled");
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get citizenshipEnabled() : Boolean
      {
         return getBoolean("talent.track.citizenship.enabled");
      }
      
      public function get safetyQuizDisabled() : Boolean
      {
         return getBoolean("safety_quiz.disabled");
      }
      
      public function requestGuide() : void
      {
         if(getBoolean("guides.enabled"))
         {
            var_619.createHelpRequest(0);
         }
      }
      
      public function reportBully(param1:int) : void
      {
         if(var_42 != null)
         {
            var_42.reportBully(param1,var_19);
         }
      }
      
      public function startPhotoReportingInNewCfhFlow(param1:int, param2:String, param3:String, param4:int) : void
      {
         if(var_42 != null)
         {
            var_42.reportedRoomId = var_19;
            var_42.reportedUserId = param1;
            var_42.reportedUserName = param2;
            var_42.reportedRoomObjectId = param4;
            var_42.reportedExtraDataId = param3;
            var_522.openReportingContentReasonCategory(9);
         }
      }
      
      public function reportUser(param1:int, param2:int, param3:String) : void
      {
         var_42.reportedUserId = param1;
         var_522.openReportingChatLineSelection();
      }
      
      public function reportUserName(param1:int, param2:String) : void
      {
         var_42.reportedUserId = param1;
         var_42.reportedUserName = param2;
         var_42.reportedRoomId = -1;
         var_522.openReportingUserName();
      }
      
      public function reportUserFromIM(param1:int) : void
      {
         if(var_42 != null)
         {
            var_42.reportedUserId = param1;
            var_522.openReportingIMSelection();
         }
      }
      
      public function reportRoom(param1:int, param2:String, param3:String) : void
      {
         if(var_42 != null)
         {
            var_42.reportedRoomId = param1;
            var_42.reportedRoomName = param2;
            var_42.reportedUserId = -1;
            var_42.reportedUserName = "";
            var_522.openReportingContentReasonCategory(4);
         }
      }
      
      public function reportThread(param1:int, param2:int) : void
      {
         if(var_42 != null)
         {
            var_42.reportedGroupId = param1;
            var_42.reportedThreadId = param2;
            var_522.openReportingContentReasonCategory(7);
         }
      }
      
      public function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : Boolean
      {
         if(var_42 != null)
         {
            if(param2.length < getInteger("help.cfh.length.minimum",15))
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
               return false;
            }
            var_42.reportSelfie(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         if(var_42 != null)
         {
            if(param2 == 0)
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
               return false;
            }
            var_42.reportPhoto(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportMessage(param1:int, param2:int, param3:int) : void
      {
         if(var_42 != null)
         {
            var_42.reportedGroupId = param1;
            var_42.reportedThreadId = param2;
            var_42.reportedMessageId = param3;
            var_522.openReportingContentReasonCategory(8);
         }
      }
      
      public function startNameChange() : void
      {
         if(var_1170 != null)
         {
            var_1170.showView();
         }
      }
      
      public function startEmergencyRequest() : void
      {
         if(var_42 != null)
         {
            var_42.openEmergencyHelpRequest();
         }
      }
      
      public function showWelcomeScreen(param1:String, param2:String, param3:int, param4:String = null) : void
      {
         if(var_1005 == null || var_1005.disposed)
         {
            var_1005 = new WelcomeScreenController(this);
         }
         var_1005.showWelcomeScreen(param1,param2,param3,param4);
      }
      
      public function showHabboWay() : void
      {
         if(!var_1167)
         {
            var_1167 = new HabboWayController(this);
         }
         var_1167.showHabboWay();
      }
      
      public function closeHabboWay() : void
      {
         if(var_1167 != null)
         {
            var_1167.closeWindow();
         }
      }
      
      public function showSafetyBooklet() : void
      {
         if(!var_1162)
         {
            var_1162 = new SafetyBookletController(this);
         }
         var_1162.openSafetyBooklet();
      }
      
      public function closeSafetyBooklet() : void
      {
         if(var_1162 != null)
         {
            var_1162.closeWindow();
         }
      }
      
      public function showHabboWayQuiz() : void
      {
         if(var_560 == null || var_560.disposed)
         {
            var_560 = new HabboWayQuizController(this);
         }
         var_560.showHabboWayQuiz();
      }
      
      public function showSafetyQuiz() : void
      {
         if(var_560 == null || var_560.disposed)
         {
            var_560 = new HabboWayQuizController(this);
         }
         var_560.showSafetyQuiz();
      }
      
      public function showTourPopup() : void
      {
         var_619.openTourPopup();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },true,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_GROUP_ROOM_INFO_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_RESIZED",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_2054(onGameStageStarting));
         addMessageEvent(new class_2169(onRoomReady));
         addMessageEvent(new class_2195(onPendingCallsForHelpDeleted));
         addMessageEvent(new class_1786(onCallForHelpDisabledNotify));
         addMessageEvent(new class_2007(onUsers));
         addMessageEvent(new class_2168(onGuestRoomResult));
         addMessageEvent(new class_1736(onPendingCallsForHelp));
         addMessageEvent(new class_2165(onMyCfhReportStatusMessageEvent));
         addMessageEvent(new class_1979(onGuideReportingStatus));
         addMessageEvent(new class_2041(onSanctionStatusEvent));
         addMessageEvent(new class_1980(onRoomEnter));
         addMessageEvent(new class_1782(onCfhTopics));
         var_1973 = new ChatEventHandler(this);
         var_619 = new GuideHelpManager(this);
         var_42 = new CallForHelpManager(this);
         var_1170 = new NameChangeController(this);
         var_5186 = new InstantMessageEventHandler(this);
         var_522 = new TopicsFlowHelpController(this);
         _sanctionInfo = new SanctionInfo(this);
         _reportStatus = new MyReportStatus(this);
         context.addLinkEventTracker(this);
         if(getBoolean("show.sanction.info.on.login") && Math.random() < 0.2)
         {
            requestSanctionInfo(true);
         }
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(var_1162 != null)
         {
            var_1162.dispose();
            var_1162 = null;
         }
         if(var_1167 != null)
         {
            var_1167.dispose();
            var_1167 = null;
         }
         if(var_1005 != null)
         {
            var_1005.dispose();
            var_1005 = null;
         }
         if(var_1170 != null)
         {
            var_1170.dispose();
            var_1170 = null;
         }
         if(var_619)
         {
            var_619.dispose();
            var_619 = null;
         }
         if(var_42)
         {
            var_42.dispose();
            var_42 = null;
         }
         if(var_560)
         {
            var_560.dispose();
            var_560 = null;
         }
         if(var_522)
         {
            var_522.dispose();
            var_522 = null;
         }
         if(_sanctionInfo)
         {
            _sanctionInfo.dispose();
            _sanctionInfo = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : class_1741
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:class_1741 = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getModalXmlWindow(param1:String) : IModalDialog
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IModalDialog = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildModalDialogFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc4_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc3_;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function setReportMessage(param1:IMessageComposer) : void
      {
         _reportMessage = param1;
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         if(_communicationManager != null && param1 != null)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      public function get ownUserName() : String
      {
         return var_1170.ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return var_1170.ownUserId;
      }
      
      public function get outsideRoom() : Boolean
      {
         return _outsideRoom;
      }
      
      public function set outsideRoom(param1:Boolean) : void
      {
         _outsideRoom = param1;
      }
      
      public function queryForPendingCallsForHelp(param1:int) : void
      {
         var_363 = param1;
         sendMessage(new class_1991());
      }
      
      public function queryForGuideReportingStatus(param1:int) : void
      {
         var_1282 = param1;
         sendMessage(new class_2038());
         sendMessage(new class_2008());
      }
      
      private function onPendingCallsForHelp(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc2_:class_1878 = class_1736(param1).getParser();
         if(_loc2_.callCount == 0 || var_363 == 9 && _loc2_.callCount < 3)
         {
            proceedWithReporting();
         }
         else
         {
            _loc4_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_.callArray.length && _loc3_ < 10)
            {
               _loc4_ += _loc2_.callArray[_loc3_].message;
               if(_loc3_ < _loc2_.callArray.length - 1 && _loc3_ < 9)
               {
                  _loc4_ += "\n";
               }
               _loc3_++;
            }
            var_42.showPendingRequest(_loc4_);
         }
      }
      
      private function onPendingCallsForHelpDeleted(param1:IMessageEvent) : void
      {
         var_522.submitCallForHelp(false);
      }
      
      private function onGuideReportingStatus(param1:class_1979) : void
      {
         var _loc2_:class_1963 = param1.getParser();
         switch(_loc2_.statusCode)
         {
            case 0:
               toggleNewHelpWindow();
               break;
            case 1:
               var_619.showPendingTicket(_loc2_.pendingTicket);
               break;
            default:
               var_619.showFeedback(_loc2_.localizationCode);
         }
      }
      
      private function proceedWithReporting() : void
      {
         switch(var_363 - 1)
         {
            case 0:
            case 2:
            case 3:
            case 6:
            case 7:
               var_42.showEmergencyHelpRequest(var_363);
               break;
            case 1:
               var_619.openReportWindow();
               break;
            case 8:
               if(_reportMessage != null)
               {
                  sendMessage(_reportMessage);
                  _reportMessage = null;
               }
         }
         var_363 = 0;
      }
      
      private function onCallForHelpDisabledNotify(param1:class_1786) : void
      {
         _windowManager.simpleAlert("${help.emergency.global_mute.caption}","${help.emergency.global_mute.subtitle}","${help.emergency.global_mute.message}","${help.emergency.global_mute.link}",param1.getParser().infoUrl);
      }
      
      public function get friendList() : class_258
      {
         return _friendList;
      }
      
      public function ignoreAndUnfriendReportedUser() : void
      {
         var _loc1_:class_1824 = null;
         if(var_42.reportedUserId > 0)
         {
            sendMessage(new class_1891(var_42.reportedUserId));
            if(_friendList.getFriend(var_42.reportedUserId) != null)
            {
               _loc1_ = new class_1824();
               _loc1_.addRemovedFriend(var_42.reportedUserId);
               sendMessage(_loc1_);
            }
         }
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1916 = null;
         var _loc2_:class_1988 = class_2007(param1).getParser();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.getUserCount())
         {
            _loc4_ = _loc2_.getUser(_loc3_);
            if(_loc4_.webID != ownUserId && _loc4_.userType == 1)
            {
               _userRegistry.registerUser(_loc4_.webID,_loc4_.name,_loc4_.figure);
            }
            _loc3_++;
         }
      }
      
      private function onGameStageStarting(param1:class_2054) : void
      {
         var _loc6_:HumanGameObjectData = null;
         var _loc2_:class_2055 = param1.getParser();
         var _loc5_:Array = _loc2_.gameObjects.gameObjects;
         var _loc4_:int = _userRegistry.roomId;
         var _loc3_:String = _userRegistry.roomName;
         _userRegistry.registerRoom(-1,"SnowStorm");
         for each(var _loc7_ in _loc5_)
         {
            _loc6_ = _loc7_ as HumanGameObjectData;
            if(_loc6_ != null && _loc6_.userId != ownUserId)
            {
               _userRegistry.registerUser(_loc6_.userId,_loc6_.name,_loc6_.figure);
            }
         }
         _userRegistry.registerRoom(_loc4_,_loc3_);
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc2_:class_1854 = class_2169(param1).getParser();
         _userRegistry.registerRoom(_loc2_.roomId,"");
      }
      
      private function onGuestRoomResult(param1:IMessageEvent) : void
      {
         var _loc2_:class_1781 = class_2168(param1).getParser();
         _userRegistry.registerRoom(_loc2_.data.flatId,_loc2_.data.roomName);
      }
      
      public function get userRegistry() : UserRegistry
      {
         return _userRegistry;
      }
      
      public function get chatRegistry() : ChatRegistry
      {
         return _chatRegistry;
      }
      
      public function get instantMessageRegistry() : InstantMessageRegistry
      {
         return _instantMessageRegistry;
      }
      
      private function onRoomEnter(param1:class_1980) : void
      {
         var _loc2_:class_1996 = class_1980(param1).getParser();
         var_19 = _loc2_.guestRoomId;
      }
      
      private function onCfhTopics(param1:class_1782) : void
      {
         var _loc2_:class_1888 = param1.getParser();
         var_1950 = _loc2_.callForHelpCategories;
      }
      
      public function get callForHelpCategories() : Vector.<class_2218>
      {
         return var_1950;
      }
      
      public function get guardiansEnabled() : Boolean
      {
         return getBoolean("guardians.enabled");
      }
      
      public function get linkPattern() : String
      {
         return "help/";
      }
      
      public function get reportedUserId() : int
      {
         return var_42.reportedUserId;
      }
      
      public function get reportedUserName() : String
      {
         return var_42.reportedUserName;
      }
      
      public function get reportedRoomId() : int
      {
         return var_42.reportedRoomId;
      }
      
      public function get reportedExtraDataId() : String
      {
         return var_42.reportedExtraDataId;
      }
      
      public function get reportedRoomObjectId() : int
      {
         return var_42.reportedRoomObjectId;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_42.reportedUserId = param1;
      }
      
      public function set reportedRoomId(param1:int) : void
      {
         var_42.reportedRoomId = param1;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1 == "help/tour")
         {
            requestGuide();
         }
         if(param1.indexOf("help/report/room/") == 0)
         {
            _loc2_ = param1.split("/");
            if(_loc2_.length >= 5)
            {
               _loc3_ = parseInt(_loc2_[3]);
               _loc4_ = unescape(_loc2_.splice(4).join("/"));
               reportRoom(_loc3_,_loc4_,"");
            }
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(var_1005 != null)
         {
            var_1005.onHabboToolbarEvent(param1);
         }
         if(var_619 != null)
         {
            var_619.onHabboToolbarEvent(param1);
         }
      }
      
      public function get callForHelpManager() : CallForHelpManager
      {
         return var_42;
      }
      
      public function toggleNewHelpWindow() : void
      {
         var_522.toggleWindow();
      }
      
      public function requestSanctionInfo(param1:Boolean) : void
      {
         sendMessage(new class_1850(param1));
      }
      
      public function requestReportsStatus() : void
      {
         sendMessage(new class_2181());
      }
      
      private function onSanctionStatusEvent(param1:class_2041) : void
      {
         _sanctionInfo.openWindow(param1);
      }
      
      private function onMyCfhReportStatusMessageEvent(param1:class_2165) : void
      {
         _reportStatus.openWindow(param1);
      }
      
      public function openCfhFaq() : void
      {
         var _loc1_:String = context.configuration.getProperty("cfh.faq.url");
         if(!StringUtil.isEmpty(_loc1_))
         {
            navigateToURL(new URLRequest(_loc1_));
         }
      }
      
      public function get guideHelpManager() : GuideHelpManager
      {
         return var_619;
      }
   }
}

