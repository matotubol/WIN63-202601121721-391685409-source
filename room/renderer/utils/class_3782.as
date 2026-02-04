package com.sulake.room.renderer.utils
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.ISortableSprite;
   
   [SecureSWF(rename="true")]
   public class class_3782 implements ISortableSprite
   {
      
      public static const const_1004:Number = 100000000;
      
      private var var_25:int = 0;
      
      private var var_26:int = 0;
      
      private var var_176:Number = 0;
      
      public var name:String = "";
      
      private var var_973:IRoomObjectSprite = null;
      
      public function class_3782()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_973 = null;
         var_176 = -100000000;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function set x(param1:int) : void
      {
         var_25 = param1;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function set y(param1:int) : void
      {
         var_26 = param1;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
      }
      
      public function get sprite() : IRoomObjectSprite
      {
         return var_973;
      }
      
      public function set sprite(param1:IRoomObjectSprite) : void
      {
         var_973 = param1;
      }
   }
}

