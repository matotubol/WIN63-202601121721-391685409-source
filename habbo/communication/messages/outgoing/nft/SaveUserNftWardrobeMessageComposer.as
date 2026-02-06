package com.sulake.habbo.communication.messages.outgoing.nft
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SaveUserNftWardrobeMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function SaveUserNftWardrobeMessageComposer(param1:String)
      {
         super();
         var_120.push(param1);
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

