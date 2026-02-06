package com.sulake.habbo.communication.messages.incoming.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.class_4044;
   
   [SecureSWF(rename="true")]
   public class class_2771 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2771(param1:Function)
      {
         super(param1,class_4044);
      }
      
      public function getParser() : class_4044
      {
         return var_15 as class_4044;
      }
   }
}

