package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CanCreateRoomEventParser implements IMessageParser
   {
      
      public static const const_1019:int = 0;
      
      public static const const_742:int = 1;
      
      private var var_1587:int;
      
      private var var_5171:int;
      
      public function CanCreateRoomEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_1587 = param1.readInteger();
         this.var_5171 = param1.readInteger();
         return true;
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
      
      public function get roomLimit() : int
      {
         return var_5171;
      }
   }
}

