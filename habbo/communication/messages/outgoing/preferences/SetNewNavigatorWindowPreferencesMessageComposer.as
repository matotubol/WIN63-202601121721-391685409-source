package com.sulake.habbo.communication.messages.outgoing.preferences
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class SetNewNavigatorWindowPreferencesMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function SetNewNavigatorWindowPreferencesMessageComposer(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
         var_120.push(param3);
         var_120.push(param4);
         var_120.push(param5);
         var_120.push(param6);
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_120 == null;
      }
   }
}

