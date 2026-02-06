package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2842;
   
   [SecureSWF(rename="true")]
   public class RoomEventEventParser implements IMessageParser
   {
      
      private var var_24:class_2842;
      
      public function RoomEventEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_24 = new class_2842(param1);
         return true;
      }
      
      public function get data() : class_2842
      {
         return var_24;
      }
   }
}

