package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class FurnitureTrophyWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FurnitureTrophyWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_FURNI_TROPHY_WIDGET";
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
         return ["RWFWM_MESSAGE_REQUEST_TROPHY"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc6_:RoomWidgetFurniToWidgetMessage = null;
         var _loc3_:IRoomObject = null;
         var _loc11_:IRoomObjectModel = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc2_:String = null;
         var _loc9_:String = null;
         var _loc10_:RoomWidgetTrophyDataUpdateEvent = null;
         if(disposed || param1 == null)
         {
            return null;
         }
         var _loc12_:* = param1.type;
         if("RWFWM_MESSAGE_REQUEST_TROPHY" === _loc12_)
         {
            _loc6_ = param1 as RoomWidgetFurniToWidgetMessage;
            _loc3_ = _container.roomEngine.getRoomObject(_loc6_.roomId,_loc6_.id,_loc6_.category);
            if(_loc3_ != null)
            {
               _loc11_ = _loc3_.getModel();
               if(_loc11_ != null)
               {
                  _loc4_ = _loc11_.getNumber("furniture_color");
                  _loc5_ = _loc11_.getString("furniture_data");
                  _loc7_ = parseInt(_loc11_.getString("furniture_extras"));
                  _loc8_ = _loc5_.substring(0,_loc5_.indexOf("\t"));
                  _loc5_ = _loc5_.substring(_loc8_.length + 1,_loc5_.length);
                  _loc2_ = _loc5_.substring(0,_loc5_.indexOf("\t"));
                  _loc9_ = _loc5_.substring(_loc2_.length + 1,_loc5_.length);
                  _loc10_ = new RoomWidgetTrophyDataUpdateEvent("RWTDUE_TROPHY_DATA",_loc4_,_loc8_,_loc2_,_loc9_,_loc7_);
                  _container.events.dispatchEvent(_loc10_);
               }
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

