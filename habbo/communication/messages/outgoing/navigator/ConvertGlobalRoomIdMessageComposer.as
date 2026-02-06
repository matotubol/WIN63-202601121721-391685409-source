package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ConvertGlobalRoomIdMessageComposer implements IMessageComposer, class_13
   {
      
      private var flatId:String;
      
      public function ConvertGlobalRoomIdMessageComposer(param1:String)
      {
         super();
         this.flatId = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [flatId];
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

