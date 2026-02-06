package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_2098;
   
   [SecureSWF(rename="true")]
   public class QuestMessageEventParser implements IMessageParser
   {
      
      private var var_147:class_2098;
      
      public function QuestMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_147 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_147 = new class_2098(param1);
         return true;
      }
      
      public function get quest() : class_2098
      {
         return var_147;
      }
   }
}

