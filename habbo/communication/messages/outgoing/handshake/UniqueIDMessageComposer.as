package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UniqueIDMessageComposer implements IMessageComposer
   {
      
      private var var_1986:String;
      
      private var var_5050:String;
      
      private var var_3416:String;
      
      public function UniqueIDMessageComposer(param1:String, param2:String, param3:String)
      {
         super();
         var_1986 = param1;
         var_5050 = param2;
         var_3416 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1986,var_5050,var_3416];
      }
   }
}

