package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2805;
   
   [SecureSWF(rename="true")]
   public class class_3540 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3540(param1:Function)
      {
         super(param1,class_2805);
      }
      
      public function getParser() : class_2805
      {
         return this.var_15 as class_2805;
      }
   }
}

