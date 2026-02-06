package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GuideSessionFeedbackMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_24:Array = [];
      
      private var _disposed:Boolean = false;
      
      public function GuideSessionFeedbackMessageComposer(param1:Boolean)
      {
         super();
         var_24.push(param1);
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

