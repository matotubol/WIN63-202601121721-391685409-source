package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class VersionCheckMessageComposer implements IMessageComposer
   {
      
      private var var_4619:int;
      
      private var var_4650:String;
      
      private var var_4424:String;
      
      public function VersionCheckMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         var_4619 = param1;
         var_4650 = param2;
         var_4424 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4619,var_4650,var_4424];
      }
   }
}

