package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.class_2108;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class class_2087 extends FurnitureMultiStateLogic
   {
      
      private var var_3699:int = 0;
      
      private var var_4946:Number = 0;
      
      private var var_1749:int = 0;
      
      public function class_2087()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            handleDataUpdateMessage(_loc2_);
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage) : void
      {
         var _loc4_:int = param1.state / 1000;
         var _loc2_:int = param1.state % 1000;
         if(_loc2_ == 0)
         {
            var_1749 = 0;
            var _loc3_:class_2108 = new class_2108();
            null.setString(String(_loc4_));
            param1 = new RoomObjectDataUpdateMessage(_loc4_,null,param1.extra);
            super.processUpdateMessage(param1);
         }
         else
         {
            var_3699 = _loc4_;
            var_4946 = param1.extra;
            var_1749 = lastUpdateTime + _loc2_;
         }
      }
      
      override public function update(param1:int) : void
      {
         if(var_1749 > 0 && param1 >= var_1749)
         {
            var_1749 = 0;
            var _loc2_:class_2108 = new class_2108();
            null.setString(String(var_3699));
            var _loc3_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(var_3699,null,var_4946);
            super.processUpdateMessage(null);
         }
         super.update(param1);
      }
   }
}

