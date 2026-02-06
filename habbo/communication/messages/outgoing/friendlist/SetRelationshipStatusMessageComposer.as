package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRelationshipStatusMessageComposer implements IMessageComposer
   {
      
      private var var_2665:int;
      
      private var var_4800:int;
      
      public function SetRelationshipStatusMessageComposer(param1:int, param2:int)
      {
         super();
         var_2665 = param1;
         var_4800 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2665,var_4800];
      }
      
      public function dispose() : void
      {
      }
   }
}

