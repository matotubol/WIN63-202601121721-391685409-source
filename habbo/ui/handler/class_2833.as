package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.CustomStackHeightWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomStackingHeightUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.CustomStackingHeightUpdateMessageEventParser;
   
   public class class_2833 implements IRoomWidgetHandler
   {
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_16:CustomStackHeightWidget;
      
      private var var_3547:int = -1;
      
      public function class_2833()
      {
         super();
      }
      
      public function set widget(param1:CustomStackHeightWidget) : void
      {
         var_16 = param1;
      }
      
      public function get type() : String
      {
         return "RWE_CUSTOM_STACK_HEIGHT";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         _container.connection.addMessageEvent(new CustomStackingHeightUpdateMessageEvent(onStackHeightUpdate));
      }
      
      private function onStackHeightUpdate(param1:CustomStackingHeightUpdateMessageEvent) : void
      {
         var _loc2_:CustomStackingHeightUpdateMessageEventParser = param1.getParser();
         if(var_16 && validateRights())
         {
            var_16.updateHeight(_loc2_.furniId,_loc2_.height);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
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
         var _loc6_:RoomEngineToWidgetEvent = null;
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               _loc6_ = param1 as RoomEngineToWidgetEvent;
               if(param1 != null && _container.roomEngine != null)
               {
                  var_3547 = _loc6_.objectId;
                  var _loc3_:IRoomObject = _container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.objectId,_loc6_.category);
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               _loc6_ = param1 as RoomEngineToWidgetEvent;
               if(param1 != null && _container.roomEngine != null && var_16 != null)
               {
                  if(var_3547 == _loc6_.objectId)
                  {
                     var_16.hide();
                  }
               }
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _container = null;
         var_16 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      private function validateRights(param1:IRoomObject = null) : Boolean
      {
         var _loc2_:Boolean = _container.roomSession.isRoomOwner;
         var _loc3_:* = _container.roomSession.roomControllerLevel >= 1;
         var _loc4_:Boolean = _container.sessionDataManager.isAnyRoomController;
         var _loc5_:Boolean = param1 && _container.isOwnerOfFurniture(param1);
         return _loc2_ || _loc4_ || _loc3_ || _loc5_;
      }
   }
}

