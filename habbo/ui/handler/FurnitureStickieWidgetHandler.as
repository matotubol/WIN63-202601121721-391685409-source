package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureStickieWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureStickieWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_STICKIE_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_STICKIE","RWSUM_STICKIE_SEND_DELETE","RWSUM_STICKIE_SEND_UPDATE"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc6_:RoomWidgetFurniToWidgetMessage = null;
         var _loc4_:IRoomObject = null;
         var _loc10_:IRoomObjectModel = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc3_:Boolean = false;
         var _loc9_:RoomWidgetStickieDataUpdateEvent = null;
         switch(param1.type)
         {
            case "RWFWM_MESSAGE_REQUEST_STICKIE":
               _loc6_ = param1 as RoomWidgetFurniToWidgetMessage;
               _loc4_ = _container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.id,_loc6_.category);
               if(_loc4_ != null)
               {
                  _loc10_ = _loc4_.getModel();
                  if(_loc10_ != null)
                  {
                     _loc2_ = _loc10_.getString("furniture_itemdata");
                     if(_loc2_.length < 6)
                     {
                        return null;
                     }
                     _loc8_ = "";
                     if(_loc2_.indexOf(" ") > 0)
                     {
                        _loc5_ = _loc2_.slice(0,_loc2_.indexOf(" "));
                        _loc8_ = _loc2_.slice(_loc2_.indexOf(" ") + 1,_loc2_.length);
                     }
                     else
                     {
                        _loc5_ = _loc2_;
                     }
                     _loc3_ = _container.roomSession.isRoomOwner || _container.sessionDataManager.isAnyRoomController;
                     _loc9_ = new RoomWidgetStickieDataUpdateEvent("RWSDUE_STICKIE_DATA",_loc6_.id,_loc4_.getType(),_loc8_,_loc5_,_loc3_);
                     _container.events.dispatchEvent(_loc9_);
                  }
               }
               break;
            case "RWSUM_STICKIE_SEND_UPDATE":
               var _loc11_:RoomWidgetStickieSendUpdateMessage = param1 as RoomWidgetStickieSendUpdateMessage;
               if(_loc11_ == null)
               {
                  return null;
               }
               if(_container != null && _container.roomEngine != null)
               {
                  _container.roomEngine.modifyRoomObjectData(null.objectId,20,null.colorHex,null.text);
               }
               break;
            case "RWSUM_STICKIE_SEND_DELETE":
               var _loc7_:RoomWidgetStickieSendUpdateMessage = param1 as RoomWidgetStickieSendUpdateMessage;
               if(_loc7_ == null)
               {
                  return null;
               }
               if(_container != null && _container.roomEngine != null)
               {
                  _container.roomEngine.deleteRoomObject(null.objectId,20);
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

