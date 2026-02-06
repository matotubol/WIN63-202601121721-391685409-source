package com.sulake.habbo.roomevents
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.WiredClickUserMessageComposer;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.notifications.class_536;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.class_32;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_setup.UserDefinedRoomEventsCtrl;
   import com.sulake.habbo.roomevents.wired_setup.class_1928;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePickerHelper;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.iid.IIDWiredMenuController;
   import flash.display.BitmapData;
   
   public class HabboUserDefinedRoomEvents extends class_17 implements IHabboUserDefinedRoomEvents
   {
      
      private var _windowManager:class_38;
      
      private var _communication:class_57;
      
      private var _toolbar:IHabboToolbar;
      
      private var _localization:class_27;
      
      private var _notifications:class_536;
      
      private var var_1634:class_1928;
      
      private var var_1692:class_1762;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_977:IRoomSession;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _userName:String;
      
      private var var_491:WiredMenuController;
      
      private var _roomUI:IRoomUI;
      
      private var var_1542:WiredVariablesSynchronizer;
      
      private var var_1594:WiredEnvironment;
      
      private var var_3902:NewVariablePickerHelper;
      
      public function HabboUserDefinedRoomEvents(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_1634 = new UserDefinedRoomEventsCtrl(this);
         var_1542 = new WiredVariablesSynchronizer(this);
         var_1594 = new WiredEnvironment(this);
         var_491 = new WiredMenuController(this,param1,0,param3);
         var_3902 = new NewVariablePickerHelper(this);
         param1.attachComponent(var_491,[new IIDWiredMenuController()]);
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:class_536):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },true,[{
            "type":"REOE_ADDED",
            "callback":roomObjectAddedHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_CREATED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_STARTED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionStateEventHandler
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }])]);
      }
      
      private function roomObjectAddedHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = param1.objectId;
         var _loc3_:int = param1.category;
         switch(_loc3_ - 10)
         {
            case 0:
               var_1634.stuffAdded(_loc2_);
               break;
            case 10:
               var_1634.stuffAdded(-_loc2_);
         }
      }
      
      override protected function initComponent() : void
      {
         var_1692 = new class_1762(this);
         _roomEngine.events.addEventListener("REE_DISPOSED",onRoomEngineEvent);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_1692 != null)
         {
            var_1692.dispose();
            var_1692 = null;
         }
         if(var_1542 != null)
         {
            var_1542.dispose();
            var_1542 = null;
         }
         if(var_1594 != null)
         {
            var_1594.dispose();
            var_1594 = null;
         }
         super.dispose();
      }
      
      public function stuffSelected(param1:int) : void
      {
         var _loc2_:ISelectedRoomObjectData = (_roomEngine as class_32).getPlacedObjectData(roomId);
         if(_loc2_ && _loc2_.id == -param1)
         {
            (_roomEngine as class_32).setPlacedObjectData(roomId,null);
            return;
         }
         var_1634.stuffSelected(param1);
         var_491.furniSelected(param1);
      }
      
      public function userSelected(param1:int) : void
      {
         if(hasClickUserWired())
         {
            send(new WiredClickUserMessageComposer(param1));
         }
         var_491.userSelected(param1);
      }
      
      public function showInspectButton() : Boolean
      {
         return var_491.isEnabled && var_491.hasReadPermission && wiredMenu.wiredInspectButton;
      }
      
      public function showToolbarMenuButton() : Boolean
      {
         return var_491.isEnabled && var_491.hasReadPermission && wiredMenu.wiredMenuButton;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return var_491.wiredWhisperDisabled;
      }
      
      public function set wiredWhisperDisabled(param1:Boolean) : void
      {
         var_491.wiredWhisperDisabled = param1;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != "HTE_TOOLBAR_CLICK")
         {
            return;
         }
         if(param1.iconId == "HTIE_ICON_WIRED_MENU")
         {
            var_491.toggleView();
         }
      }
      
      public function send(param1:IMessageComposer, param2:Boolean = false) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String) : class_1741
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:class_1741 = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function refreshButton(param1:class_1812, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         if(!param6)
         {
            param6 = param2;
         }
         var _loc7_:class_2251 = param1.findChildByName(param2) as class_2251;
         if(!param3)
         {
            _loc7_.visible = false;
         }
         else
         {
            prepareButton(_loc7_,param6,param4,param5);
            _loc7_.visible = true;
         }
      }
      
      private function prepareButton(param1:class_2251, param2:String, param3:Function, param4:int) : void
      {
         param1.id = param4;
         param1.procedure = param3;
         if(param1.bitmap != null)
         {
            return;
         }
         param1.bitmap = getButtonImage(param2);
         param1.width = param1.bitmap.width;
         param1.height = param1.bitmap.height;
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         var _loc4_:String = param1 + param2;
         var _loc6_:IAsset = assets.getAssetByName(_loc4_);
         var _loc5_:BitmapDataAsset = BitmapDataAsset(_loc6_);
         var _loc3_:BitmapData = BitmapData(_loc5_.content);
         return _loc3_.clone();
      }
      
      public function get wiredCtrl() : class_1928
      {
         return var_1634;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSE_CREATED":
            case "RSE_STARTED":
            case "RSE_ENDED":
               var_977 = param1.session;
         }
      }
      
      public function get roomId() : int
      {
         return var_977 ? var_977.roomId : 0;
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_977;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get wiredMenu() : WiredMenuController
      {
         return var_491;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      private function onRoomEngineEvent(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "REE_DISPOSED")
         {
            var_1542.clear();
            var_1594.clear();
            var_1634.close();
         }
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get roomDesktop() : IRoomDesktop
      {
         return _roomUI.desktop;
      }
      
      public function get notifications() : class_536
      {
         return _notifications;
      }
      
      public function get variablesSynchronizer() : WiredVariablesSynchronizer
      {
         return var_1542;
      }
      
      public function hasClickUserWired() : Boolean
      {
         return var_1594.hasClickUserWired;
      }
      
      public function switchPlayTestMode() : void
      {
         var_491.setPlayTestMode(!var_491.playTestMode,true,true);
      }
      
      public function resetCache() : void
      {
         var_1634.clearCache();
      }
      
      public function get variablePickerHelper() : NewVariablePickerHelper
      {
         return var_3902;
      }
   }
}

