package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class WiredSetPreferencesMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function WiredSetPreferencesMessageComposer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
         var_120.push(param3);
         var_120.push(0);
         var_120.push(param4);
         var_120.push(param5);
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

