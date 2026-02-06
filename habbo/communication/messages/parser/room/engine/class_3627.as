package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_3627
   {
      
      private var var_4181:int;
      
      private var var_3854:Vector3d;
      
      private var var_202:Vector3d;
      
      private var var_3284:String;
      
      private var _animationTime:Number;
      
      private var var_586:Number;
      
      private var _headDirection:Number;
      
      public function class_3627(param1:int, param2:Vector3d, param3:Vector3d, param4:String, param5:Number, param6:Number, param7:Number)
      {
         super();
         var_4181 = param1;
         var_3854 = param2;
         var_202 = param3;
         var_3284 = param4;
         _animationTime = param5;
         var_586 = param6;
         _headDirection = param7;
      }
      
      public function get userIndex() : int
      {
         return var_4181;
      }
      
      public function get source() : Vector3d
      {
         return var_3854;
      }
      
      public function get target() : Vector3d
      {
         return var_202;
      }
      
      public function get moveType() : String
      {
         return var_3284;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get bodyDirection() : Number
      {
         return var_586;
      }
      
      public function get headDirection() : Number
      {
         return _headDirection;
      }
   }
}

