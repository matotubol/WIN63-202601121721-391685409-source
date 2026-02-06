package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   public class GetSnowWarGameTokensOfferComposer implements IMessageComposer, class_13
   {
      
      private var var_24:Array = [];
      
      public function GetSnowWarGameTokensOfferComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_24 == null;
      }
   }
}

