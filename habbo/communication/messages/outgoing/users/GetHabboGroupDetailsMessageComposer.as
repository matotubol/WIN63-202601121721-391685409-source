package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetHabboGroupDetailsMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetHabboGroupDetailsMessageComposer(param1:int, param2:Boolean)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
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

