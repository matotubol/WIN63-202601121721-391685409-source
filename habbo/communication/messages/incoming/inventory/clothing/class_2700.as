package com.sulake.habbo.communication.messages.incoming.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.class_3950;
   
   [SecureSWF(rename="true")]
   public class class_2700 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2700(param1:Function)
      {
         super(param1,class_3950);
      }
      
      public function getParser() : class_3950
      {
         return var_15 as class_3950;
      }
   }
}

