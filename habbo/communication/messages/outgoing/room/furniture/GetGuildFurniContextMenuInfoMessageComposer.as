package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetGuildFurniContextMenuInfoMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      private var var_3004:int;
      
      public function GetGuildFurniContextMenuInfoMessageComposer(param1:int, param2:int)
      {
         super();
         var_315 = param1;
         var_3004 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315,var_3004];
      }
   }
}

