package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.class_3722;
   
   [SecureSWF(rename="true")]
   public class class_3360 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3360(param1:Function)
      {
         super(param1,class_3722);
      }
      
      public function getParser() : class_3722
      {
         return var_15 as class_3722;
      }
   }
}

