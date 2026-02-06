package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomFilterSettingsMessageEventParser implements IMessageParser
   {
      
      private var var_516:Array;
      
      public function RoomFilterSettingsMessageEventParser()
      {
         super();
      }
      
      public function get badWords() : Array
      {
         return var_516;
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_516 = [];
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_516.push(param1.readString());
            _loc3_++;
         }
         return false;
      }
   }
}

