package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ModToolSanctionComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function ModToolSanctionComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.var_120.push(param1);
         this.var_120.push(param2);
         this.var_120.push(param3);
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

