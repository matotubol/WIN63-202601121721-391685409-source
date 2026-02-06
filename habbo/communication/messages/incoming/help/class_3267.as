package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.class_3936;
   
   [SecureSWF(rename="true")]
   public class class_3267 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3267(param1:Function)
      {
         super(param1,class_3936);
      }
      
      public function getParser() : class_3936
      {
         return var_15 as class_3936;
      }
   }
}

