package com.sulake.habbo.communication.messages.outgoing.userclassification
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomUsersClassificationMessageComposer implements IMessageComposer
   {
      
      private var var_3033:String;
      
      public function RoomUsersClassificationMessageComposer(param1:String)
      {
         super();
         var_3033 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_3033];
      }
      
      public function dispose() : void
      {
         var_3033 = null;
      }
   }
}

