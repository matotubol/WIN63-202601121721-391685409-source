package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2460;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2638;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2950;
   
   [SecureSWF(rename="true")]
   public class OfficialRoomsEventParser implements IMessageParser
   {
      
      private var var_24:class_2638;
      
      private var var_3188:class_2460;
      
      private var _promotedRooms:class_2950;
      
      public function OfficialRoomsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_2638(param1);
         var _loc2_:int = param1.readInteger();
         if(_loc2_ > 0)
         {
            var_3188 = new class_2460(param1);
         }
         _promotedRooms = new class_2950(param1);
         return true;
      }
      
      public function get data() : class_2638
      {
         return var_24;
      }
      
      public function get adRoom() : class_2460
      {
         return var_3188;
      }
      
      public function get promotedRooms() : class_2950
      {
         return _promotedRooms;
      }
   }
}

