package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_4082;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalHallOfFameMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_4082;
      
      public function CommunityGoalHallOfFameMessageEventParser()
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
         var_24 = new class_4082(param1);
         return true;
      }
      
      public function get data() : class_4082
      {
         return var_24;
      }
   }
}

