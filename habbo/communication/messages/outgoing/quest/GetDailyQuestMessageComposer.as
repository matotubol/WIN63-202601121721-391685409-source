package com.sulake.habbo.communication.messages.outgoing.quest
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetDailyQuestMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function GetDailyQuestMessageComposer(param1:Boolean, param2:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

