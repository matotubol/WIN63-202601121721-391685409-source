package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class ModeratorActionMessageComposer implements IMessageComposer, class_13
   {
      
      public static const const_963:int = 0;
      
      public static const const_705:int = 1;
      
      public static const const_1210:int = 3;
      
      public static const const_854:int = 4;
      
      private var var_120:Array = [];
      
      public function ModeratorActionMessageComposer(param1:int, param2:String, param3:String)
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

