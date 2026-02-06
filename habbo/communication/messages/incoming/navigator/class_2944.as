package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.class_4012;
   
   [SecureSWF(rename="true")]
   public class class_2944 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2944(param1:Function)
      {
         super(param1,class_4012);
      }
      
      public function getParser() : class_4012
      {
         return this.var_15 as class_4012;
      }
   }
}

