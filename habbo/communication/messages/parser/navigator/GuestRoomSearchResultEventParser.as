package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3464;
   
   [SecureSWF(rename="true")]
   public class GuestRoomSearchResultEventParser implements IMessageParser
   {
      
      private var var_24:class_3464;
      
      public function GuestRoomSearchResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_24 = new class_3464(param1);
         return true;
      }
      
      public function get data() : class_3464
      {
         return var_24;
      }
   }
}

