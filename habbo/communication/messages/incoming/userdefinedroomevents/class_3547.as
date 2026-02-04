package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3967;
   
   [SecureSWF(rename="true")]
   public class class_3547 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3547(param1:Function)
      {
         super(param1,class_3967);
      }
      
      public function getParser() : class_3967
      {
         return this.var_15 as class_3967;
      }
   }
}

