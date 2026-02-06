package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.class_3836;
   
   [SecureSWF(rename="true")]
   public class class_2896 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2896(param1:Function)
      {
         super(param1,class_3836);
      }
      
      public function getParser() : class_3836
      {
         return this.var_15 as class_3836;
      }
   }
}

