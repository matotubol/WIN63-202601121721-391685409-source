package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.class_2098;
   
   [SecureSWF(rename="true")]
   public class QuestCompletedMessageEventParser implements IMessageParser
   {
      
      private var var_3213:class_2098;
      
      private var var_4711:Boolean;
      
      public function QuestCompletedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3213 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3213 = new class_2098(param1);
         var_4711 = param1.readBoolean();
         return true;
      }
      
      public function get questData() : class_2098
      {
         return var_3213;
      }
      
      public function get showDialog() : Boolean
      {
         return var_4711;
      }
   }
}

