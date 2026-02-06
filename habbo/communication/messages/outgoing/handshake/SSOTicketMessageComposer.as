package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class SSOTicketMessageComposer implements IMessageComposer
   {
      
      private var var_986:Array;
      
      public function SSOTicketMessageComposer(param1:String)
      {
         super();
         var_986 = [];
         var_986.push(param1);
         var_986.push(getTimer());
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_986;
      }
   }
}

