package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_4039;
   
   [SecureSWF(rename="true")]
   public class ModeratorRoomInfoEventParser implements IMessageParser
   {
      
      private var var_24:class_4039;
      
      public function ModeratorRoomInfoEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_4039(param1);
         return true;
      }
      
      public function get data() : class_4039
      {
         return var_24;
      }
   }
}

