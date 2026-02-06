package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class UpdateRoomCategoryAndTradeSettingsComposer implements IMessageComposer, class_13
   {
      
      private var var_120:Array = [];
      
      public function UpdateRoomCategoryAndTradeSettingsComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_120 = [param1,param2,param3];
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

