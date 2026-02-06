package com.sulake.habbo.communication.messages.incoming.vault
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.class_3933;
   
   [SecureSWF(rename="true")]
   public class class_2737 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2737(param1:Function)
      {
         super(param1,class_3933);
      }
      
      public function getParser() : class_3933
      {
         return var_15 as class_3933;
      }
   }
}

