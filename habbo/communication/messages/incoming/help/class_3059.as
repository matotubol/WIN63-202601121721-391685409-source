package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.class_4007;
   
   [SecureSWF(rename="true")]
   public class class_3059 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3059(param1:Function)
      {
         super(param1,class_4007);
      }
      
      public function getParser() : class_4007
      {
         return var_15 as class_4007;
      }
   }
}

