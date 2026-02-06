package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class WiredSetObjectVariableValueMessageComposer implements IMessageComposer, class_13
   {
      
      public static const const_224:int = 0;
      
      public static const const_900:int = 1;
      
      public static const const_1206:int = 2;
      
      private var var_120:Array = [];
      
      public function WiredSetObjectVariableValueMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
         var_120.push(param3);
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

