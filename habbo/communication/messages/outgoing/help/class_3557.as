package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_3557 implements IMessageComposer
   {
      
      private var var_2943:int;
      
      public function class_3557(param1:int)
      {
         super();
         var_2943 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2943];
      }
      
      public function dispose() : void
      {
      }
   }
}

