package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeUserNameInRoomMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function ChangeUserNameInRoomMessageComposer(param1:String)
      {
         super();
         var_24 = [];
         var_24.push(param1);
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

