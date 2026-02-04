package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class class_3388 implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function class_3388(param1:Dictionary)
      {
         super();
         if(param1 == null)
         {
            var_120.push(0);
            return;
         }
         var _loc2_:int = 0;
         for(var _loc4_ in param1)
         {
            _loc2_ += 1;
         }
         var_120.push(_loc2_);
         for(var _loc3_ in param1)
         {
            var _loc5_:int = int(param1[_loc3_]);
            var_120.push(_loc3_);
            var_120.push(0);
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

