package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.class_3527;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import flash.utils.getTimer;
   
   public class class_2136 extends FurnitureMultiStateLogic
   {
      
      private static const UPDATE_INTERVAL:int = 33;
      
      private static const MAX_UPDATE_TIME:int = 1000;
      
      private var var_1651:int = 0;
      
      private var _lastUpdate:int = 0;
      
      private var var_1928:int = 33;
      
      public function class_2136()
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
               updateTotal(_loc2_.result);
            }
         }
      }
      
      private function get currentTotal() : int
      {
         return int(object.getModelController().getNumber("furniture_vote_counter_count"));
      }
      
      private function updateTotal(param1:int) : void
      {
         var_1651 = param1;
         if(_lastUpdate == 0)
         {
            object.getModelController().setNumber("furniture_vote_counter_count",param1);
            _lastUpdate = getTimer();
            return;
         }
         if(var_1651 != currentTotal)
         {
            var _loc2_:int = Math.abs(var_1651 - currentTotal);
            var_1928 = 33;
            _lastUpdate = getTimer();
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.update(param1);
         if(object != null)
         {
            if(currentTotal != var_1651 && param1 >= _lastUpdate + var_1928)
            {
               _loc2_ = param1 - _lastUpdate;
               _loc3_ = _loc2_ / var_1928;
               _loc4_ = 1;
               if(var_1651 < currentTotal)
               {
                  _loc4_ = -1;
               }
               if(_loc3_ > _loc4_ * (var_1651 - currentTotal))
               {
                  _loc3_ = _loc4_ * (var_1651 - currentTotal);
               }
               object.getModelController().setNumber("furniture_vote_counter_count",currentTotal + _loc4_ * _loc3_);
               _lastUpdate = param1 - (_loc2_ - _loc3_ * var_1928);
            }
         }
      }
   }
}

