package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureNftCreditLogic extends class_1738
   {
      
      private static const EMERALD_HAND_TYPE:String = "nft_emerald_emerhand";
      
      private static const EMERALD_EGG_TYPE:String = "nft_emerald_eggmerald";
      
      public function FurnitureNftCreditLogic()
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
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null || object == null)
         {
            return;
         }
         var _loc5_:String = object.getType();
         var _loc2_:Array = _loc5_.match(/\d+$/);
         var _loc4_:int = int(_loc2_ ? int(_loc2_[0]) : NaN);
         if(isNaN(_loc4_))
         {
            if(_loc5_ == "nft_emerald_emerhand")
            {
               _loc4_ = 15000;
            }
            else if(_loc5_ == "nft_emerald_eggmerald")
            {
               _loc4_ = 2000;
            }
         }
         var _loc3_:IRoomObjectModelController = object.getModelController();
         if(_loc3_ != null)
         {
            _loc3_.setNumber("furniture_credit_value",_loc4_);
            _loc3_.setString("furniture_nft_credit","true");
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

