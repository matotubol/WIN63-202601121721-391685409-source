package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureStickieLogic extends class_1738
   {
      
      public function FurnitureStickieLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE__STICKIE","ROFCAE_STICKIE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         setColorIndexFromItemData();
         if(object != null)
         {
            object.getModelController().setString("furniture_is_stickie","");
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:RoomObjectWidgetRequestEvent = null;
         super.processUpdateMessage(param1);
         if(param1 is RoomObjectItemDataUpdateMessage)
         {
            _loc2_ = new RoomObjectWidgetRequestEvent("ROWRE__STICKIE",object);
            if(_loc2_ != null)
            {
               eventDispatcher.dispatchEvent(_loc2_);
            }
         }
         setColorIndexFromItemData();
      }
      
      protected function setColorIndexFromItemData() : void
      {
         var _loc3_:String = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(object != null)
         {
            _loc3_ = object.getModel().getString("furniture_data");
            _loc1_ = new Array("9CCEFF","FF9CFF","9CFF9C","FFFF33");
            _loc2_ = int(_loc1_.indexOf(_loc3_));
            if(_loc2_ < 0)
            {
               _loc2_ = 3;
            }
            object.getModelController().setNumber("furniture_color",_loc2_ + 1);
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
            _loc1_ = new RoomObjectFurnitureActionEvent("ROFCAE_STICKIE",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

