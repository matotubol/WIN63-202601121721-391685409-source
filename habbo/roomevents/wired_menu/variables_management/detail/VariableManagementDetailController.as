package com.sulake.habbo.roomevents.wired_menu.variables_management.detail
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
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
   import flash.utils.Dictionary;
   import package_189.WiredVariable;
   import package_201.WiredUserPermanentVariablesList;
   import package_201.class_3731;
   import package_201.class_3948;
   import package_89.class_2336;
   import package_89.class_3579;
   
   public class VariableManagementDetailController extends class_17 implements IVariableManagementDetailController
   {
      
      private var _communicationManager:class_57;
      
      private var _localizationManager:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_18:VariableManagementDetailView;
      
      private var var_24:WiredUserPermanentVariablesList;
      
      private var var_1448:Dictionary = new Dictionary();
      
      public function VariableManagementDetailController(param1:HabboUserDefinedRoomEvents, param2:class_15, param3:uint = 0, param4:class_40 = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new class_3579(onGetData));
         _messageEvents.push(new class_2336(onGetResult));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      private function onGetData(param1:class_3579) : void
      {
         var event:class_3579 = param1;
         var parser:class_3731 = event.getParser();
         roomEvents.variablesSynchronizer.getAllVariables((function():*
         {
            var variablesReceived:Function;
            return variablesReceived = function(param1:Vector.<WiredVariable>):void
            {
               initializeData(param1,parser.list);
            };
         })());
      }
      
      private function initializeData(param1:Vector.<WiredVariable>, param2:WiredUserPermanentVariablesList) : void
      {
         var_24 = param2;
         var_1448 = new Dictionary();
         for each(var _loc3_ in param1)
         {
            var_1448[_loc3_.variableId] = _loc3_;
         }
         dataIsReady();
      }
      
      private function dataIsReady() : void
      {
         if(var_18 == null)
         {
            var_18 = new VariableManagementDetailView(this,_windowManager);
         }
         var_18.displayNewData();
         if(!var_18.isShowing())
         {
            var_18.show();
         }
      }
      
      private function onGetResult(param1:class_2336) : void
      {
         var _loc2_:class_3948 = param1.getParser();
         var _loc3_:Boolean = _loc2_.success;
         if(!_loc3_)
         {
            _roomEvents.notifications.addItem("${wiredmenu.variable_management_detail.notification.modification_failed}","wired");
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
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
      
      public function get data() : WiredUserPermanentVariablesList
      {
         return var_24;
      }
      
      public function get view() : VariableManagementDetailView
      {
         return var_18;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function get variablesById() : Dictionary
      {
         return var_1448;
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
         var_24 = null;
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

