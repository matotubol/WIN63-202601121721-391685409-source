package com.sulake.habbo.communication.messages.outgoing.landingview
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GetPromoArticlesMessageComposer implements IMessageComposer, class_13
   {
      
      public function GetPromoArticlesMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

