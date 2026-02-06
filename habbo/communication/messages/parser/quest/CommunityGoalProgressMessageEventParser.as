package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4083;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalProgressMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_4083;
      
      public function CommunityGoalProgressMessageEventParser()
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
         var_24 = new class_4083(param1);
         return true;
      }
      
      public function get data() : class_4083
      {
         return var_24;
      }
   }
}

