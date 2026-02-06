package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_4047;
   
   [SecureSWF(rename="true")]
   public class class_2480 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2480(param1:Function)
      {
         super(param1,class_4047);
      }
      
      public function getParser() : class_4047
      {
         return var_15 as class_4047;
      }
   }
}

