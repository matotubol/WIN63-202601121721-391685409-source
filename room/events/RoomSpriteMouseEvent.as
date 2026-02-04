package com.sulake.room.events
{
   public class RoomSpriteMouseEvent
   {
      
      private var var_230:String = "";
      
      private var var_3500:String = "";
      
      private var var_3401:String = "";
      
      private var var_4452:String = "";
      
      private var var_4223:Number = 0;
      
      private var var_4469:Number = 0;
      
      private var var_4280:Number = 0;
      
      private var var_3917:Number = 0;
      
      private var _ctrlKey:Boolean = false;
      
      private var _altKey:Boolean = false;
      
      private var _shiftKey:Boolean = false;
      
      private var var_3995:Boolean = false;
      
      private var var_4795:int = 0;
      
      private var var_4666:int = 0;
      
      public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super();
         var_230 = param1;
         var_3500 = param2;
         var_3401 = param3;
         var_4452 = param4;
         var_4223 = param5;
         var_4469 = param6;
         var_4280 = param7;
         var_3917 = param8;
         _ctrlKey = param9;
         _altKey = param10;
         _shiftKey = param11;
         var_3995 = param12;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get eventId() : String
      {
         return var_3500;
      }
      
      public function get canvasId() : String
      {
         return var_3401;
      }
      
      public function get spriteTag() : String
      {
         return var_4452;
      }
      
      public function get screenX() : Number
      {
         return var_4223;
      }
      
      public function get screenY() : Number
      {
         return var_4469;
      }
      
      public function get localX() : Number
      {
         return var_4280;
      }
      
      public function get localY() : Number
      {
         return var_3917;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _ctrlKey;
      }
      
      public function get altKey() : Boolean
      {
         return _altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _shiftKey;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_3995;
      }
      
      public function get spriteOffsetX() : int
      {
         return var_4795;
      }
      
      public function set spriteOffsetX(param1:int) : void
      {
         var_4795 = param1;
      }
      
      public function get spriteOffsetY() : int
      {
         return var_4666;
      }
      
      public function set spriteOffsetY(param1:int) : void
      {
         var_4666 = param1;
      }
   }
}

