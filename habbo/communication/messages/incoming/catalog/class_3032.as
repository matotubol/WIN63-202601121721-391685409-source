package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.class_4068;
   
   [SecureSWF(rename="true")]
   public class class_3032 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3032(param1:Function)
      {
         super(param1,class_4068);
      }
      
      public function getParser() : class_4068
      {
         return this.var_15 as class_4068;
      }
   }
}

