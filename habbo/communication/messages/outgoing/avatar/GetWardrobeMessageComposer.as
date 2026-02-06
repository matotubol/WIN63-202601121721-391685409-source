package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetWardrobeMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetWardrobeMessageComposer()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

