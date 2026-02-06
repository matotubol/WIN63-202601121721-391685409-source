package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangePostureMessageComposer implements IMessageComposer
   {
      
      private var var_359:int;
      
      public function ChangePostureMessageComposer(param1:int)
      {
         super();
         var_359 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_359];
      }
      
      public function dispose() : void
      {
      }
   }
}

