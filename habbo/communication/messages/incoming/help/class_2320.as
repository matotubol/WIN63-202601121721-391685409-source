package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.class_3761;
   
   [SecureSWF(rename="true")]
   public class class_2320 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2320(param1:Function)
      {
         super(param1,class_3761);
      }
      
      public function getParser() : class_3761
      {
         return var_15 as class_3761;
      }
   }
}

