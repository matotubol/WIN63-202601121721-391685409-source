package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GuideSessionOnDutyUpdateMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_24:Array = [];
      
      private var _disposed:Boolean = false;
      
      public function GuideSessionOnDutyUpdateMessageComposer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean)
      {
         super();
         var_24 = [param1,param2,param3,param4];
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

