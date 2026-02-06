package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_3303;
   
   [SecureSWF(rename="true")]
   public class AchievementEventParser implements IMessageParser
   {
      
      private var var_92:class_3303;
      
      public function AchievementEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_92 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_92 = new class_3303(param1);
         return true;
      }
      
      public function get achievement() : class_3303
      {
         return var_92;
      }
   }
}

