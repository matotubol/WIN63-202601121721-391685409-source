package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_13;
   
   [SecureSWF(rename="true")]
   public class UpdateRoomFilterMessageComposer implements IMessageComposer, class_13
   {
      
      public static var var_5312:Boolean = true;
      
      public static var var_5325:Boolean = false;
      
      private var var_120:Array = [];
      
      public function UpdateRoomFilterMessageComposer(param1:int, param2:Boolean, param3:String)
      {
         super();
         var_120.push(param1);
         var_120.push(param2);
         var_120.push(param3);
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

