package com.sulake.habbo.communication.messages.incoming.help
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.help.class_4031;
   
   [SecureSWF(rename="true")]
   public class class_3219 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3219(param1:Function)
      {
         super(param1,class_4031);
      }
      
      public function getParser() : class_4031
      {
         return var_15 as class_4031;
      }
   }
}

