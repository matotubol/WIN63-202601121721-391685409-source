package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LetUserInMessageComposer implements IMessageComposer
   {
      
      private var var_986:Array;
      
      public function LetUserInMessageComposer(param1:String, param2:Boolean)
      {
         super();
         var_986 = [param1,param2];
      }
      
      public function dispose() : void
      {
         var_986 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_986;
      }
   }
}

