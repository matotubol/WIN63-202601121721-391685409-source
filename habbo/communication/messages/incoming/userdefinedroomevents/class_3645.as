package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2795;
   
   [SecureSWF(rename="true")]
   public class class_3645 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3645(param1:Function)
      {
         super(param1,class_2795);
      }
      
      public function getParser() : class_2795
      {
         return this.var_15 as class_2795;
      }
   }
}

