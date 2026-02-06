package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class SetObjectDataMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function SetObjectDataMessageComposer(param1:int, param2:class_55)
      {
         super();
         var_24.push(param1);
         var_24.push(param2.length * 2);
         for each(var _loc3_ in param2.getKeys())
         {
            var_24.push(_loc3_);
            var_24.push(param2.getValue(_loc3_));
         }
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

