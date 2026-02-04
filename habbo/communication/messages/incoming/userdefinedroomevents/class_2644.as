package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3573;
   
   [SecureSWF(rename="true")]
   public class class_2644 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2644(param1:Function)
      {
         super(param1,class_3573);
      }
      
      public function getParser() : class_3573
      {
         return this.var_15 as class_3573;
      }
   }
}

