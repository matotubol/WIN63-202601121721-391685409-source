package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniEngravingWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class class_2664 implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:FriendFurniEngravingWidget = null;
      
      public function class_2664()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FRIEND_FURNI_ENGRAVING";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:FriendFurniEngravingWidget) : void
      {
         var_16 = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
         var_16 = null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc4_:RoomEngineObjectEvent = null;
         var _loc2_:IRoomObject = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc3_:StringArrayStuffData = null;
         if(disposed || param1 == null)
         {
            return;
         }
         var _loc6_:* = param1.type;
         if("RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING" === _loc6_)
         {
            _loc4_ = RoomEngineObjectEvent(param1);
            _loc2_ = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
            if(_loc2_ != null)
            {
               _loc5_ = _loc2_.getModel();
               if(_loc5_ != null)
               {
                  _loc3_ = new StringArrayStuffData();
                  _loc3_.initializeFromRoomObjectModel(_loc5_);
                  var_16.open(_loc2_.getId(),_loc5_.getNumber("furniture_friendfurni_engraving_type"),_loc3_);
               }
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
   }
}

