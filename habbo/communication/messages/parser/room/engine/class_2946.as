package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_2946
   {
      
      private var var_2536:int;
      
      private var var_3854:Vector3d;
      
      private var var_202:Vector3d;
      
      private var _animationTime:Number;
      
      private var var_207:Number;
      
      public function class_2946(param1:int, param2:Vector3d, param3:Vector3d, param4:Number, param5:Number)
      {
         super();
         var_2536 = param1;
         var_3854 = param2;
         var_202 = param3;
         _animationTime = param4;
         var_207 = param5;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get source() : Vector3d
      {
         return var_3854;
      }
      
      public function get target() : Vector3d
      {
         return var_202;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get rotation() : Number
      {
         return var_207;
      }
   }
}

