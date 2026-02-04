package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.class_3527;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class class_2068 extends FurnitureMultiStateLogic
   {
      
      public function class_2068()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:class_3527 = null;
         super.processUpdateMessage(param1);
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.data as class_3527;
            if(_loc2_ != null)
            {
               object.getModelController().setNumber("furniture_vote_majority_result",_loc2_.result);
            }
         }
      }
   }
}

