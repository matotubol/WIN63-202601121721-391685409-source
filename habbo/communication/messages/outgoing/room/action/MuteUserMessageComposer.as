package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class MuteUserMessageComposer implements IMessageComposer
   {
      
      private var var_1270:int;
      
      private var var_1951:int = 0;
      
      private var var_4309:int;
      
      public function MuteUserMessageComposer(param1:int, param2:int, param3:int = 0)
      {
         super();
         var_1270 = param1;
         var_1951 = param3;
         var_4309 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1270,var_1951,var_4309];
      }
   }
}

