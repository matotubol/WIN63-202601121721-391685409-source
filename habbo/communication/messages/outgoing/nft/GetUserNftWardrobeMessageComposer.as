package com.sulake.habbo.communication.messages.outgoing.nft
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetUserNftWardrobeMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function GetUserNftWardrobeMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

