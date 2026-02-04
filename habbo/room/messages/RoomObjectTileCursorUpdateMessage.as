package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectTileCursorUpdateMessage extends RoomObjectUpdateMessage
   {
      
      private var var_385:Number;
      
      private var var_4484:String;
      
      private var var_588:Boolean;
      
      private var var_4512:Boolean;
      
      public function RoomObjectTileCursorUpdateMessage(param1:Vector3d, param2:Number, param3:Boolean, param4:String, param5:Boolean = false)
      {
         super(param1,null);
         var_385 = param2;
         var_588 = param3;
         var_4484 = param4;
         var_4512 = param5;
      }
      
      public function get height() : Number
      {
         return var_385;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function get sourceEventId() : String
      {
         return var_4484;
      }
      
      public function get toggleVisibility() : Boolean
      {
         return var_4512;
      }
   }
}

