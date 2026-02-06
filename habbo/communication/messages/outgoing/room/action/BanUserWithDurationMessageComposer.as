package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BanUserWithDurationMessageComposer implements IMessageComposer
   {
      
      private var var_1270:int;
      
      private var var_1951:int = 0;
      
      private var var_4343:String;
      
      public function BanUserWithDurationMessageComposer(param1:int, param2:String, param3:int = 0)
      {
         super();
         var_1270 = param1;
         var_1951 = param3;
         var_4343 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1270,var_1951,var_4343];
      }
   }
}

