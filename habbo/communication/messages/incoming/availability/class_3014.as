package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.class_3898;
   
   [SecureSWF(rename="true")]
   public class class_3014 extends MessageEvent implements IMessageEvent
   {
      
      public function class_3014(param1:Function)
      {
         super(param1,class_3898);
      }
      
      public function getParser() : class_3898
      {
         return var_15 as class_3898;
      }
   }
}

