package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.class_3986;
   
   [SecureSWF(rename="true")]
   public class class_2402 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2402(param1:Function)
      {
         super(param1,class_3986);
      }
      
      public function getParser() : class_3986
      {
         return this.var_15 as class_3986;
      }
   }
}

