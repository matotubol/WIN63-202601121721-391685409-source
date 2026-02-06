package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredPermissionsEventParser;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogListController;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogsConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.WiredMenuInspectionTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings.WiredMenuSettingsTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.WiredMenuOverviewTab;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.detail.VariableManagementDetailController;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.overview.VariableManagementOverviewController;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
   import package_192.WiredGetRoomLogsComposer;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredPermissionsEvent;
   
   public class WiredMenuController extends class_17 implements ILinkEventTracker, class_1761, class_13
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:class_48;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_18:WiredMenuView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2782:Boolean;
      
      private var var_3124:Boolean;
      
      private var var_2364:VariableManagementOverviewController;
      
      private var var_2496:VariableManagementDetailController;
      
      private var var_967:WiredRoomLogListController;
      
      private var var_2772:Boolean;
      
      private var var_2975:Boolean;
      
      private var var_2234:Boolean;
      
      private var var_3018:Boolean;
      
      private var var_3164:Boolean;
      
      private var var_1134:Boolean = false;
      
      public function WiredMenuController(param1:HabboUserDefinedRoomEvents, param2:class_15, param3:uint = 0, param4:class_40 = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredPermissionsEvent(onWiredPermissions));
         _messageEvents.push(new AccountPreferencesEvent(onAccountPreferences));
         _messageEvents.push(new YouAreControllerMessageEvent(onControllerMessageEvent));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
         var_2364 = new VariableManagementOverviewController(param1,param2,0,param4);
         var_2496 = new VariableManagementDetailController(param1,param2,0,param4);
         var_967 = new WiredRoomLogListController(param1,param2,0,param4);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "wiredmenu/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            windowManager.alert("${wiredmenu.invalid_room.title}","${wiredmenu.invalid_room.desc}",0,null);
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showView();
            if(_loc2_.length >= 3)
            {
               view.selectTab(_loc2_[2]);
               if(_loc2_[2] == WiredMenuTabConfigs.TAB_INSPECTION_ID)
               {
                  routeInspectionLink(param1);
               }
               else if(_loc2_[2] == WiredMenuTabConfigs.TAB_OVERVIEW_ID)
               {
                  routeOverviewLink(param1);
               }
            }
         }
         if(_loc2_[1] == "logs")
         {
            if(!isShowing())
            {
               showView();
               view.selectTab(WiredMenuTabConfigs.TAB_MONITOR_ID);
            }
            if(var_967.view == null || !var_967.view.isShowing())
            {
               var_967.send(new WiredGetRoomLogsComposer(1,WiredRoomLogsConfig.PAGE_SIZE,-1,-1,""));
            }
            else
            {
               var_967.view.activate();
            }
         }
      }
      
      public function routeInspectionLink(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 5)
         {
            return;
         }
         var _loc3_:WiredMenuInspectionTab = view.activeTab as WiredMenuInspectionTab;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = parseInt(_loc2_[4]);
         if(_loc2_[3] == String(WiredInputSourcePicker.var_128))
         {
            _loc3_.inspectFurni(_loc4_,true);
         }
         else if(_loc2_[3] == String(WiredInputSourcePicker.USER_SOURCE))
         {
            _loc3_.inspectUser(_loc4_,true);
         }
      }
      
      public function routeOverviewLink(param1:String) : void
      {
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 4)
         {
            return;
         }
         var _loc2_:WiredMenuOverviewTab = view.activeTab as WiredMenuOverviewTab;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = _loc3_[3];
         _loc2_.jumpToVariableByName(_loc4_);
      }
      
      public function toggleView() : void
      {
         if(isShowing())
         {
            hideView();
         }
         else
         {
            showView();
         }
      }
      
      private function showView() : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            return;
         }
         if(!var_18 || var_18.disposed)
         {
            var_18 = new WiredMenuView(this,_windowManager);
            var_18.initialize();
         }
         var_18.show();
      }
      
      private function hideView() : void
      {
         if(!var_18 || var_18.disposed)
         {
            return;
         }
         var_18.hide();
      }
      
      private function isShowing() : Boolean
      {
         return var_18 != null && !var_18.disposed && var_18.isShowing();
      }
      
      public function get isEnabled() : Boolean
      {
         return getBoolean("wired.menu.enabled");
      }
      
      public function isRoomOwnerOrStaff() : Boolean
      {
         var _loc3_:IRoomSession = _roomEvents.roomSession;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Boolean = _sessionDataManager.hasSecurity(4);
         var _loc1_:Boolean = _roomEvents.roomSession.isRoomOwner;
         return _loc2_ || _loc1_;
      }
      
      public function get hasReadPermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return var_3124;
      }
      
      public function get hasWritePermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return var_2782;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("REE_DISPOSED" === _loc2_)
         {
            if(var_18 != null)
            {
               var_18.dispose();
               var_18 = null;
            }
         }
      }
      
      private function onWiredPermissions(param1:WiredPermissionsEvent) : void
      {
         var _loc2_:WiredPermissionsEventParser = param1.getParser();
         var_2782 = _loc2_.canModify;
         var_3124 = _loc2_.canRead;
         if(var_18 != null && !var_18.disposed)
         {
            if(!var_3124)
            {
               var_18.dispose();
               var_18 = null;
            }
            else
            {
               var_18.permissionsUpdated();
            }
         }
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         var_2772 = param1.getParser().wiredMenuButton;
         var_2975 = param1.getParser().wiredInspectButton;
         setPlayTestMode(param1.getParser().playTestMode);
         var_3018 = param1.getParser().wiredWhisperDisabled;
         var_3164 = param1.getParser().showAllNotifications;
      }
      
      private function onControllerMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:IRoomSession = roomEvents.roomSession;
         if(_loc2_ != null && var_2234)
         {
            roomEvents.notifications.addItem(localizationManager.getLocalization("wiredmenu.settings.preferences.notification.playtest"),"info","icon_wired_notification_png","wiredmenu/open/settings");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         if(param1.type != "RSE_STARTED")
         {
            return;
         }
         param1.session.playTestMode = var_2234;
      }
      
      public function get wiredMenuButton() : Boolean
      {
         return var_2772;
      }
      
      public function set wiredMenuButton(param1:Boolean) : void
      {
         var_2772 = param1;
         roomEvents.events.dispatchEvent(new WiredMenuEvent("WIRED_MENU_BUTTON_PREFERENCE_CHANGED"));
      }
      
      public function get wiredInspectButton() : Boolean
      {
         return var_2975;
      }
      
      public function get showAllNotifications() : Boolean
      {
         return var_3164;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return var_3018;
      }
      
      public function set wiredWhisperDisabled(param1:Boolean) : void
      {
         var_3018 = param1;
         sendPreferences();
      }
      
      public function set wiredInspectButton(param1:Boolean) : void
      {
         var_2975 = param1;
      }
      
      public function set showAllNotifications(param1:Boolean) : void
      {
         var_3164 = param1;
      }
      
      public function get playTestMode() : Boolean
      {
         return var_2234;
      }
      
      public function setPlayTestMode(param1:Boolean, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc6_:IRoomSession = roomEvents.roomSession;
         if(_loc6_ != null)
         {
            _loc6_.playTestMode = param1;
         }
         if(var_2234 != param1 && param2)
         {
            var_2234 = param1;
            var _loc5_:String = "wiredmenu.settings.preferences.notification.playtest." + (param1 ? "enabled" : "disabled");
            roomEvents.notifications.addItem(localizationManager.getLocalization(null),"info","icon_wired_notification_png","wiredmenu/open/settings");
            if(param3)
            {
               sendPreferences();
               if(var_18 != null)
               {
                  var _loc4_:WiredMenuSettingsTab = var_18.activeTab as WiredMenuSettingsTab;
                  if(_loc4_ == null)
                  {
                     return;
                  }
                  null.updatePreferencesUI();
               }
            }
         }
      }
      
      public function furniSelected(param1:int) : void
      {
         if(!isEnabled || var_18 == null || var_18.disposed)
         {
            return;
         }
         if(var_18.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (var_18.activeTab as WiredMenuInspectionTab).inspectFurni(param1);
         }
      }
      
      public function userSelected(param1:int) : void
      {
         if(!isEnabled || var_18 == null || var_18.disposed)
         {
            return;
         }
         if(var_18.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (var_18.activeTab as WiredMenuInspectionTab).inspectUser(param1);
         }
      }
      
      public function sendPreferences() : void
      {
         send(new WiredSetPreferencesMessageComposer(wiredMenuButton,wiredInspectButton,playTestMode,wiredWhisperDisabled,showAllNotifications));
      }
      
      override public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1134 = true;
         if(var_2364)
         {
            var_2364.dispose();
            var_2364 = null;
         }
         if(var_2496)
         {
            var_2496.dispose();
            var_2496 = null;
         }
         if(var_967)
         {
            var_967.dispose();
            var_967 = null;
         }
         if(var_18)
         {
            var_18.dispose();
            var_18 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _communicationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get view() : WiredMenuView
      {
         return var_18;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function get variablesSynchronizer() : WiredVariablesSynchronizer
      {
         return _roomEvents.variablesSynchronizer;
      }
      
      public function get roomLogListController() : WiredRoomLogListController
      {
         return var_967;
      }
   }
}

