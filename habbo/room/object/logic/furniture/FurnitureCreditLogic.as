package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureCreditLogic extends class_1738
   {
      
      public function FurnitureCreditLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE__CREDITFURNI"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc2_:IRoomObjectModelController = null;
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc4_:XMLList = param1.credits;
         if(_loc4_.length() == 0)
         {
            return;
         }
         var _loc3_:Number = Number(_loc4_[0].@value);
         if(object != null)
         {
            _loc2_ = object.getModelController();
            if(_loc2_ != null)
            {
               _loc2_.setNumber("furniture_credit_value",_loc3_);
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
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE__CREDITFURNI",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
         super.useObject();
      }
   }
}

