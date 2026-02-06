package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.class_3989;
   
   [SecureSWF(rename="true")]
   public class class_2331 extends MessageEvent
   {
      
      public function class_2331(param1:Function, param2:Class)
      {
         super(param1,param2);
      }
      
      public function getParser() : class_3989
      {
         return var_15 as class_3989;
      }
   }
}

