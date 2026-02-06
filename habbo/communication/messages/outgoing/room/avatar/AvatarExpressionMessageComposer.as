package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AvatarExpressionMessageComposer implements IMessageComposer
   {
      
      private var var_2834:int = 0;
      
      public function AvatarExpressionMessageComposer(param1:int)
      {
         super();
         var_2834 = param1;
      }
      
      public function dispose() : void
      {
         var_2834 = 0;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2834];
      }
   }
}

