package com.sulake.habbo.communication.messages.outgoing.room.bots
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetBotCommandConfigurationDataComposer implements IMessageComposer
   {
      
      private var var_1504:int;
      
      private var var_4603:int;
      
      public function GetBotCommandConfigurationDataComposer(param1:int, param2:int)
      {
         super();
         var_1504 = param1;
         var_4603 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1504,var_4603];
      }
   }
}

