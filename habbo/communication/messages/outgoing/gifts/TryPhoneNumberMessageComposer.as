package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberMessageComposer implements IMessageComposer, class_13
   {
      
      public static const const_20:int = -1;
      
      private var var_120:Array = [];
      
      public function TryPhoneNumberMessageComposer(param1:String, param2:String)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
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

