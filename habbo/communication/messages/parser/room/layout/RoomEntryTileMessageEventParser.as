package com.sulake.habbo.communication.messages.parser.room.layout
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomEntryTileMessageEventParser implements IMessageParser
   {
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var var_772:uint;
      
      public function RoomEntryTileMessageEventParser()
      {
         super();
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get dir() : uint
      {
         return var_772;
      }
      
      public function flush() : Boolean
      {
         var_25 = 0;
         var_26 = 0;
         var_772 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_25 = param1.readInteger();
         var_26 = param1.readInteger();
         var_772 = param1.readInteger();
         return true;
      }
   }
}

