package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboActivityPointNotificationMessageEventParser implements IMessageParser
   {
      
      private var _amount:int = 0;
      
      private var var_4328:int = 0;
      
      private var var_230:int;
      
      public function HabboActivityPointNotificationMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _amount = param1.readInteger();
         var_4328 = param1.readInteger();
         var_230 = param1.readInteger();
         return true;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get change() : int
      {
         return var_4328;
      }
      
      public function get type() : int
      {
         return var_230;
      }
   }
}

