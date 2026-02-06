package com.sulake.habbo.communication.messages.outgoing.sound
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class GetSongInfoMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function GetSongInfoMessageComposer(param1:Array)
      {
         super();
         var_120.push(param1.length);
         for each(var _loc2_ in param1)
         {
            var_120.push(_loc2_);
         }
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
         return false;
      }
   }
}

