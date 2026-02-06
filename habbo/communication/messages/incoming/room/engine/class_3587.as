package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class class_3587
   {
      
      private var var_197:int = 0;
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_176:Number = 0;
      
      private var var_4486:Number = 0;
      
      private var var_1440:Number = 0;
      
      private var var_1401:Number = 0;
      
      private var var_4389:Number = 0;
      
      private var var_772:int = 0;
      
      private var var_3962:int = 0;
      
      private var var_289:Array = [];
      
      private var var_407:Boolean = false;
      
      private var var_4738:Boolean = false;
      
      private var _skipPositionUpdate:Boolean = false;
      
      public function class_3587(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:int, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Boolean, param13:Array, param14:Boolean)
      {
         super();
         var_197 = param1;
         var_25 = param2;
         var_26 = param3;
         var_176 = param4;
         var_4486 = param5;
         var_772 = param6;
         var_3962 = param7;
         var_1440 = param8;
         var_1401 = param9;
         var_4389 = param10;
         var_407 = param11;
         var_4738 = param12;
         var_289 = param13;
         _skipPositionUpdate = param14;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function get localZ() : Number
      {
         return var_4486;
      }
      
      public function get targetX() : Number
      {
         return var_1440;
      }
      
      public function get targetY() : Number
      {
         return var_1401;
      }
      
      public function get targetZ() : Number
      {
         return var_4389;
      }
      
      public function get dir() : int
      {
         return var_772;
      }
      
      public function get dirHead() : int
      {
         return var_3962;
      }
      
      public function get isMoving() : Boolean
      {
         return var_407;
      }
      
      public function get canStandUp() : Boolean
      {
         return var_4738;
      }
      
      public function get actions() : Array
      {
         return var_289.slice();
      }
      
      public function get skipPositionUpdate() : Boolean
      {
         return _skipPositionUpdate;
      }
   }
}

