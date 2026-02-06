package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerSavePresetMessageComposer implements IMessageComposer
   {
      
      private var _presetNumber:int;
      
      private var var_3981:int;
      
      private var var_4303:String;
      
      private var var_4426:int;
      
      private var var_4472:Boolean;
      
      private var var_315:int;
      
      public function RoomDimmerSavePresetMessageComposer(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:int)
      {
         super();
         _presetNumber = param1;
         var_3981 = param2;
         var_4303 = param3;
         var_4426 = param4;
         var_4472 = param5;
         var_315 = param6;
      }
      
      public function getMessageArray() : Array
      {
         return [_presetNumber,var_3981,var_4303,var_4426,var_4472,false,var_315];
      }
      
      public function dispose() : void
      {
      }
   }
}

