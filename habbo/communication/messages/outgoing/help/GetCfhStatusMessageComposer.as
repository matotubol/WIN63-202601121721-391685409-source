package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetCfhStatusMessageComposer implements IMessageComposer
   {
      
      private var var_4916:Boolean;
      
      public function GetCfhStatusMessageComposer(param1:Boolean)
      {
         super();
         var_4916 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4916];
      }
      
      public function dispose() : void
      {
      }
   }
}

