package com.sulake.habbo.communication.messages.outgoing.collectibles
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MintItemMessageComposer implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function MintItemMessageComposer(param1:int, param2:String)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = [];
      }
   }
}

