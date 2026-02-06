package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromIMMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function CallForHelpFromIMMessageComposer(param1:String, param2:int, param3:int, param4:Array, param5:String, param6:String)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
         this.var_120.push(param3);
         this.var_120.push(param4.length / 2);
         this.var_120 = this.var_120.concat(param4);
         this.var_120.push(param5);
         this.var_120.push(param6);
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

