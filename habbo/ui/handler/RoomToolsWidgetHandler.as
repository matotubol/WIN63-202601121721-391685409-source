package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import flash.events.Event;
   import package_1.class_2313;
   import package_17.class_1781;
   import package_42.class_1945;
   import package_42.class_2168;
   
   public class RoomToolsWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean;
      
      private var _communicationManagerMessageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>();
      
      private var _communicationManager:class_57;
      
      private var _navigator:class_41;
      
      private var var_16:RoomToolsWidget;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      public function RoomToolsWidgetHandler()
      {
         super();
      }
      
      public function set widget(param1:RoomToolsWidget) : void
      {
         var_16 = param1;
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:class_1781 = class_2168(param1).getParser();
         var _loc4_:class_1945 = _loc2_.data;
         if(_loc4_)
         {
            var_16.updateRoomData(_loc4_);
         }
         if(_loc2_.enterRoom)
         {
            if(_loc4_)
            {
               _loc3_ = _loc4_.showOwner ? var_16.localizations.getLocalizationWithParams("room.tool.room.owner.prefix","By") + " " + _loc4_.ownerName : var_16.localizations.getLocalizationWithParams("room.tool.public.room","Public room");
               var_16.showRoomInfo(true,_loc4_.roomName,_loc3_,_loc4_.tags);
               var_16.storeRoomData(_loc4_);
               var_16.enterNewRoom(_loc4_.flatId);
            }
         }
      }
      
      public function toggleRoomInfoWindow() : void
      {
         _navigator.toggleRoomInfoVisibility();
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         _navigator.goToPrivateRoom(param1);
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_TOOLS";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.sessionDataManager)
         {
            _container.sessionDataManager.events.removeEventListener("APUE_UPDATED",onSessionDataPreferences);
         }
         _container = param1;
         if(_container == null)
         {
            return;
         }
         _container.sessionDataManager.events.addEventListener("APUE_UPDATED",onSessionDataPreferences);
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWZTM_ZOOM_TOGGLE"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      private function onSessionDataPreferences(param1:SessionDataPreferencesEvent) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _disposed = true;
         if(_communicationManager)
         {
            for each(var _loc1_ in _communicationManagerMessageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
            _communicationManagerMessageEvents = null;
            _communicationManager = null;
         }
         if(_container && _container.sessionDataManager)
         {
            _container.sessionDataManager.events.removeEventListener("APUE_UPDATED",onSessionDataPreferences);
         }
         _navigator = null;
         var_16 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set navigator(param1:class_41) : void
      {
         _navigator = param1;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _container.sessionDataManager;
      }
      
      public function set communicationManager(param1:class_57) : void
      {
         _communicationManager = param1;
         _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new class_2168(onRoomInfo)));
      }
      
      public function rateRoom() : void
      {
         _container.connection.send(new class_2313(1));
      }
      
      public function get canRate() : Boolean
      {
         return _navigator.canRateRoom();
      }
   }
}

