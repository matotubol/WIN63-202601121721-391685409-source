package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_2098;
   
   [SecureSWF(rename="true")]
   public class QuestDailyMessageEventParser implements IMessageParser
   {
      
      private var var_147:class_2098;
      
      private var var_3670:int;
      
      private var var_3475:int;
      
      public function QuestDailyMessageEventParser()
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
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            var_147 = new class_2098(param1);
            var_3670 = param1.readInteger();
            var_3475 = param1.readInteger();
         }
         return true;
      }
      
      public function get quest() : class_2098
      {
         return var_147;
      }
      
      public function get easyQuestCount() : int
      {
         return var_3670;
      }
      
      public function get hardQuestCount() : int
      {
         return var_3475;
      }
   }
}

