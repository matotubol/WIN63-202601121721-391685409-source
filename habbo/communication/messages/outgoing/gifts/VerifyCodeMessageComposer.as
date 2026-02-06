package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class VerifyCodeMessageComposer implements IMessageComposer, class_13
   {
      
      public static const const_20:int = -1;
      
      private var var_120:Array = [];
      
      public function VerifyCodeMessageComposer(param1:String)
      {
         super();
         this.var_120.push(param1);
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

