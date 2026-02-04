package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3056;
   
   [SecureSWF(rename="true")]
   public class class_2813 extends MessageEvent implements IMessageEvent
   {
      
      public static const const_747:int = 6;
      
      public static const const_450:int = 7;
      
      public function class_2813(param1:Function)
      {
         super(param1,class_3056);
      }
      
      public function getParser() : class_3056
      {
         return this.var_15 as class_3056;
      }
   }
}

