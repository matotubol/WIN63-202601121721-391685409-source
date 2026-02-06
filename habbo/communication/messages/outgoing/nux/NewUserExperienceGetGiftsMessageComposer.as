package com.sulake.habbo.communication.messages.outgoing.nux
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGetGiftsMessageComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function NewUserExperienceGetGiftsMessageComposer(param1:Vector.<class_2597>)
      {
         super();
         var_120.push(param1.length * 3);
         for each(var _loc2_ in param1)
         {
            var_120.push(_loc2_.dayIndex);
            var_120.push(_loc2_.stepIndex);
            var_120.push(_loc2_.giftIndex);
         }
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

