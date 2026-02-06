package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GetGuestRoomMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function GetGuestRoomMessageComposer(param1:int, param2:Boolean, param3:Boolean)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2 ? 1 : 0);
         this.var_120.push(param3 ? 1 : 0);
      }
      
      public function getMessageArray() : Array
      {
         return this.var_120;
      }
      
      public function dispose() : void
      {
         this.var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

