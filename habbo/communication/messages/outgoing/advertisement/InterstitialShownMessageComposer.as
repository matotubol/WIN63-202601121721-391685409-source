package com.sulake.habbo.communication.messages.outgoing.advertisement
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class InterstitialShownMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function InterstitialShownMessageComposer()
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

