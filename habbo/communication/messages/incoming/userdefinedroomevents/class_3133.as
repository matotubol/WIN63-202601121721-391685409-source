package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3453;
   
   [SecureSWF(rename="true")]
   public class class_3133 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3133(param1:Function)
      {
         super(param1,class_3453);
      }
      
      public function getParser() : class_3453
      {
         return this.var_15 as class_3453;
      }
   }
}

