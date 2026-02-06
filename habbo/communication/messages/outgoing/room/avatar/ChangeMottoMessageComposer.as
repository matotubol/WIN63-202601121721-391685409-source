package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeMottoMessageComposer implements IMessageComposer
   {
      
      private var var_3144:String;
      
      public function ChangeMottoMessageComposer(param1:String)
      {
         super();
         var_3144 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_3144];
      }
   }
}

