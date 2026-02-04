package com.sulake.habbo.moderation
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendBar;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDNewModerationTool;
   import com.sulake.iid.IIDSessionDataManager;
   import package_18.class_2218;
   import package_79.class_2259;
   
   public class ModerationManager extends class_17 implements IHabboModeration
   {
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:class_41;
      
      private var _soundManager:class_544;
      
      private var _tracking:class_53;
      
      private var _friendBar:IHabboFriendBar;
      
      private var var_5084:ModerationMessageHandler;
      
      private var var_1945:IssueManager;
      
      private var var_1688:StartPanelCtrl;
      
      private var var_3933:WindowTracker;
      
      private var _initMsg:class_2259;
      
      private var var_4734:int;
      
      public function ModerationManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_1688 = new StartPanelCtrl(this);
         var_3933 = new WindowTracker();
         param1.attachComponent(new class_1852(param1,param2,param3),[new IIDNewModerationTool()]);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            class_2078.setLocalizationManager(param1);
         }),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(HabboComponentFlags.isRoomViewerMode(flags))
         {
            return;
         }
         var_5084 = new ModerationMessageHandler(this);
         var_1945 = new IssueManager(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_1688 != null)
         {
            var_1688.dispose();
            var_1688 = null;
         }
         super.dispose();
      }
      
      public function userSelected(param1:int, param2:String) : void
      {
         class_21.log("USER SELECTED: " + param1 + ", " + param2);
         this.var_1688.userSelected(param1,param2);
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get issueManager() : IssueManager
      {
         return var_1945;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get startPanel() : StartPanelCtrl
      {
         return var_1688;
      }
      
      public function get initMsg() : class_2259
      {
         return _initMsg;
      }
      
      public function get messageHandler() : ModerationMessageHandler
      {
         return var_5084;
      }
      
      public function get windowTracker() : WindowTracker
      {
         return var_3933;
      }
      
      public function get currentFlatId() : int
      {
         return var_4734;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function set initMsg(param1:class_2259) : void
      {
         _initMsg = param1;
      }
      
      public function set currentFlatId(param1:int) : void
      {
         var_4734 = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return _sessionDataManager.hasSecurity(5);
      }
      
      public function getXmlWindow(param1:String, param2:String = "_xml", param3:int = 1) : class_1741
      {
         var _loc6_:IAsset = null;
         var _loc4_:XmlAsset = null;
         var _loc5_:class_1741 = null;
         try
         {
            _loc6_ = assets.getAssetByName(param1 + param2);
            _loc4_ = XmlAsset(_loc6_);
            _loc5_ = _windowManager.buildFromXML(XML(_loc4_.content),param3);
         }
         catch(e:Error)
         {
         }
         return _loc5_;
      }
      
      public function openHkPage(param1:String, param2:String) : void
      {
         var _loc4_:String = getProperty(param1);
         var _loc5_:String = _loc4_ + param2;
         HabboWebTools.navigateToURL(_loc5_,"housekeeping");
      }
      
      public function goToRoom(param1:int) : void
      {
         _navigator.goToPrivateRoom(param1);
      }
      
      public function openThread(param1:int, param2:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2);
      }
      
      public function openThreadMessage(param1:int, param2:int, param3:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2 + "/" + param3);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_tracking != null)
         {
            _tracking.trackEventLog("Moderation",param2,param1);
         }
      }
      
      internal function trackGoogle(param1:String, param2:int = -1) : void
      {
         if(_tracking != null)
         {
            _tracking.trackGoogle("moderationManager",param1,param2);
         }
      }
      
      public function set cfhTopics(param1:Vector.<class_2218>) : void
      {
         var_1945.setCfhTopics(param1);
      }
   }
}

