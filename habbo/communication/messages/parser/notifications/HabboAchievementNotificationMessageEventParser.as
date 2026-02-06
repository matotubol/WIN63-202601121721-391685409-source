package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.notifications.class_2847;
   
   [SecureSWF(rename="true")]
   public class HabboAchievementNotificationMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_2847;
      
      public function HabboAchievementNotificationMessageEventParser()
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
         var_24 = new class_2847(param1);
         return true;
      }
      
      public function get data() : class_2847
      {
         return var_24;
      }
   }
}

