package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import flash.utils.getTimer;
   
   public class class_2241 extends class_1738
   {
      
      private static const UPDATE_INTERVAL:int = 50;
      
      private static const MAX_UPDATE_TIME:int = 3000;
      
      private var var_808:int = 0;
      
      private var _lastUpdate:int = 0;
      
      private var var_1928:int = 50;
      
      public function class_2241()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            updateScore(_loc2_.state);
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      private function updateScore(param1:int) : void
      {
         var_808 = param1;
         var _loc2_:int = int(object.getState(0));
         if(var_808 != _loc2_)
         {
            var _loc3_:int = var_808 - _loc2_;
            var_1928 = 50;
            _lastUpdate = getTimer();
         }
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.update(param1);
         if(object != null)
         {
            _loc2_ = int(object.getState(0));
            if(_loc2_ != var_808 && param1 >= _lastUpdate + var_1928)
            {
               _loc3_ = param1 - _lastUpdate;
               _loc4_ = _loc3_ / var_1928;
               _loc5_ = 1;
               if(var_808 < _loc2_)
               {
                  _loc5_ = -1;
               }
               if(_loc4_ > _loc5_ * (var_808 - _loc2_))
               {
                  _loc4_ = _loc5_ * (var_808 - _loc2_);
               }
               object.setState(_loc2_ + _loc5_ * _loc4_,0);
               _lastUpdate = param1 - (_loc3_ - _loc4_ * var_1928);
            }
         }
      }
   }
}

