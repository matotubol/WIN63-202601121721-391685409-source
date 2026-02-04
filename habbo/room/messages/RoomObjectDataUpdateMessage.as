package com.sulake.habbo.room.messages
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage
   {
      
      private var var_61:int;
      
      private var var_24:IStuffData = null;
      
      private var var_3221:Number = NaN;
      
      public function RoomObjectDataUpdateMessage(param1:int, param2:IStuffData, param3:Number = NaN)
      {
         super(null,null);
         var_61 = param1;
         var_24 = param2;
         var_3221 = param3;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get data() : IStuffData
      {
         return var_24;
      }
      
      public function get extra() : Number
      {
         return var_3221;
      }
   }
}

