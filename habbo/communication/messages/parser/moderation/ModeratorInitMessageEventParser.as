package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorInitMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_2259;
      
      public function ModeratorInitMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(var_24 != null)
         {
            var_24.dispose();
            var_24 = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_2259(param1);
         return true;
      }
      
      public function get data() : class_2259
      {
         return var_24;
      }
   }
}

