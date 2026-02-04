package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.class_2551;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class class_1794 extends FurnitureMultiStateLogic
   {
      
      public function class_1794()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_HIDE_AREA"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null && _loc2_.data != null)
         {
            _loc2_.data.writeRoomObjectModel(object.getModelController());
            if(object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               setupObject();
            }
         }
      }
      
      private function setupObject() : void
      {
         if(object == null || object.getModelController() == null)
         {
            return;
         }
         var _loc2_:class_2551 = new class_2551();
         _loc2_.initializeFromRoomObjectModel(object.getModel());
         var _loc5_:int = _loc2_.getValue(0);
         var _loc6_:int = _loc2_.getValue(1);
         var _loc7_:int = _loc2_.getValue(2);
         var _loc4_:int = _loc2_.getValue(3);
         var _loc8_:int = _loc2_.getValue(4);
         var _loc9_:* = _loc2_.getValue(5) == 1;
         var _loc3_:* = _loc2_.getValue(6) == 1;
         var _loc1_:* = _loc2_.getValue(7) == 1;
         object.getModelController().setNumber("furniture_area_hide_root_x",_loc6_);
         object.getModelController().setNumber("furniture_area_hide_root_y",_loc7_);
         object.getModelController().setNumber("furniture_area_hide_width",_loc4_);
         object.getModelController().setNumber("furniture_area_hide_length",_loc8_);
         object.getModelController().setNumber("furniture_area_hide_invisibility",_loc9_ ? 1 : 0);
         object.getModelController().setNumber("furniture_area_hide_wallitems",_loc3_ ? 1 : 0);
         object.getModelController().setNumber("furniture_area_hide_invert",_loc1_ ? 1 : 0);
         object.setState(_loc5_,0);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_HIDE_AREA",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:RoomObjectEvent = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:* = param1.type;
         if("doubleClick" !== _loc4_)
         {
            super.mouseEvent(param1,param2);
         }
         else
         {
            if(param1.spriteTag == "turn_on" || param1.spriteTag == "turn_off")
            {
               _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object);
            }
            else if(eventDispatcher != null && object != null)
            {
               _loc3_ = new RoomObjectWidgetRequestEvent("ROWRE_HIDE_AREA",object);
            }
            eventDispatcher.dispatchEvent(_loc3_);
         }
      }
   }
}

