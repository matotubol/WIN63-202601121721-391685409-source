package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FloodControlMessageEventParser implements IMessageParser
   {
      
      private var var_3073:int = 0;
      
      public function FloodControlMessageEventParser()
      {
         super();
      }
      
      public function get seconds() : int
      {
         return var_3073;
      }
      
      public function flush() : Boolean
      {
         var_3073 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_3073 = param1.readInteger();
         return true;
      }
   }
}

