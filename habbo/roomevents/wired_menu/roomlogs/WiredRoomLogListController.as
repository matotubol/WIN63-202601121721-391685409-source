package com.sulake.habbo.roomevents.wired_menu.roomlogs
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import package_172.WiredRoomLogsEvent;
   import package_192.WiredGetRoomLogsComposer;
   import package_203.WiredLogPage;
   import package_203.WiredRoomLogsEventParser;
   
   public class WiredRoomLogListController extends class_17 implements class_2746
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_18:WiredRoomLogListView;
      
      private var var_215:WiredLogPage;
      
      private var var_2559:Boolean;
      
      public function WiredRoomLogListController(param1:HabboUserDefinedRoomEvents, param2:class_15, param3:uint = 0, param4:class_40 = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredRoomLogsEvent(onGetPage));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      private function onGetPage(param1:WiredRoomLogsEvent) : void
      {
         var _loc2_:WiredRoomLogsEventParser = param1.getParser();
         if(_loc2_.page.amount != WiredRoomLogsConfig.PAGE_SIZE)
         {
            return;
         }
         if((var_18 == null || !var_18.isShowing()) && !var_2559)
         {
            return;
         }
         var_215 = _loc2_.page;
         if(var_18 == null)
         {
            var_18 = new WiredRoomLogListView(this,_windowManager);
         }
         var_18.displayNewPage(!var_2559);
         if(!var_18.isShowing())
         {
            var_18.show();
         }
         var_2559 = false;
      }
      
      public function send(param1:WiredGetRoomLogsComposer, param2:Boolean = false) : void
      {
         if(!param2)
         {
            var_2559 = true;
         }
         _communicationManager.connection.send(param1);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),setWindowManager),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
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
         }])]);
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
      }
      
      private function setWindowManager(param1:class_38) : void
      {
         _windowManager = param1;
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
               var_18.hide();
            }
         }
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
      
      public function get localizationManager() : class_27
      {
         return _localizationManager;
      }
      
      public function get page() : WiredLogPage
      {
         return var_215;
      }
      
      public function get view() : WiredRoomLogListView
      {
         return var_18;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         var_215 = null;
         _communicationManager = null;
         _localizationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _roomEngine = null;
         _roomEvents = null;
         _disposed = true;
         super.dispose();
      }
   }
}

