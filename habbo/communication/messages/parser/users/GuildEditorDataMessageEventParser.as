package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_1957;
   
   [SecureSWF(rename="true")]
   public class GuildEditorDataMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_1957;
      
      public function GuildEditorDataMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_1957(param1);
         return true;
      }
      
      public function get data() : class_1957
      {
         return var_24;
      }
   }
}

