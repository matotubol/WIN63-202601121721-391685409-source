package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SelectClubGiftComposer implements IMessageComposer
   {
      
      private var var_2711:String;
      
      public function SelectClubGiftComposer(param1:String)
      {
         super();
         var_2711 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2711];
      }
      
      public function dispose() : void
      {
         var_2711 = null;
      }
   }
}

