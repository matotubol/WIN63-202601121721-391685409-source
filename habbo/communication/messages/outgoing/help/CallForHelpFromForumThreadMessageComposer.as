package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class CallForHelpFromForumThreadMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function CallForHelpFromForumThreadMessageComposer(param1:int, param2:int, param3:int, param4:String, param5:String, param6:String)
      {
         super();
         this.var_120 = [param1,param2,param3,param4,param5,param6];
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

