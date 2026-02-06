package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToSomeRoomMessageComposer implements IMessageComposer
   {
      
      private var var_230:String;
      
      public function ForwardToSomeRoomMessageComposer(param1:String)
      {
         super();
         var_230 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_230];
      }
      
      public function dispose() : void
      {
         var_230 = null;
      }
   }
}

