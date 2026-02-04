package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2371;
   
   [SecureSWF(rename="true")]
   public class class_2594 extends MessageEvent implements IMessageEvent
   {
      
      public function class_2594(param1:Function)
      {
         super(param1,class_2371);
      }
      
      public function getParser() : class_2371
      {
         return this.var_15 as class_2371;
      }
   }
}

