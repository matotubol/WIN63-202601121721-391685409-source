package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class RoomQueueStatusMessageEventParser implements IMessageParser
   {
      
      private var _flatId:int = 0;
      
      private var var_2174:class_55 = new class_55();
      
      private var var_3446:int = 0;
      
      public function RoomQueueStatusMessageEventParser()
      {
         super();
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get activeTarget() : int
      {
         return var_3446;
      }
      
      public function flush() : Boolean
      {
         var_2174.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2174.reset();
         _flatId = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         var _loc7_:int = 0;
         while(0 < _loc4_)
         {
            var _loc2_:String = param1.readString();
            var _loc5_:int = param1.readInteger();
            var_3446 = 0;
            var _loc6_:class_2305 = new class_2305(null,0);
            var _loc3_:int = param1.readInteger();
            var _loc8_:int = 0;
            var_2174.add(null.target,null);
            _loc7_++;
         }
         return true;
      }
      
      public function getQueueSetTargets() : Array
      {
         return var_2174.getKeys();
      }
      
      public function getQueueSet(param1:int) : class_2305
      {
         return var_2174.getValue(param1) as class_2305;
      }
   }
}

