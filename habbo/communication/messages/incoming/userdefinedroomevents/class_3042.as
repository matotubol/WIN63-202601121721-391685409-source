package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3042 extends class_2397
   {
      
      private var var_3051:int;
      
      public function class_3042(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
         var_3051 = param1.readInteger();
      }
      
      public function get delayInPulses() : int
      {
         return var_3051;
      }
      
      public function set delayInPulses(param1:int) : void
      {
         var_3051 = param1;
      }
   }
}

