package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureClothingChangeLogic extends class_1738
   {
      
      public function FurnitureClothingChangeLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE_CLOTHING_CHANGE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(object == null || object.getModel() == null)
         {
            return;
         }
         var _loc2_:String = object.getModel().getString("furniture_data");
         updateClothingData(_loc2_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:IStuffData = null;
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.data;
            if(_loc2_ != null)
            {
               updateClothingData(_loc2_.getLegacyString());
            }
         }
      }
      
      private function updateClothingData(param1:String) : void
      {
         var _loc2_:Array = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.split(",");
            if(_loc2_.length > 0)
            {
               object.getModelController().setString("furniture_clothing_boy",_loc2_[0]);
            }
            if(_loc2_.length > 1)
            {
               object.getModelController().setString("furniture_clothing_girl",_loc2_[1]);
            }
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:* = param1.type;
         if("doubleClick" !== _loc3_)
         {
            super.mouseEvent(param1,param2);
         }
         else
         {
            useObject();
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_CLOTHING_CHANGE",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

