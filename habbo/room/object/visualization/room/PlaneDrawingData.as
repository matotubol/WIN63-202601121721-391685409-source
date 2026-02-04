package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.room.object.visualization.class_2507;
   import flash.geom.Point;
   
   public class PlaneDrawingData implements class_2507
   {
      
      private var var_176:Number;
      
      private var var_3439:Vector.<Point>;
      
      private var _color:uint;
      
      private var var_2119:Array;
      
      private var var_2024:Array;
      
      private var var_1898:Array;
      
      private var var_2041:Array;
      
      private var var_4563:Boolean = false;
      
      private var var_770:Array = [];
      
      public function PlaneDrawingData(param1:PlaneDrawingData = null, param2:uint = 0, param3:Boolean = false)
      {
         super();
         var_2119 = [];
         var_2024 = [];
         var_1898 = [];
         var_2041 = [];
         if(param1 != null)
         {
            var_2119 = param1.var_2119;
            var_2024 = param1.var_2024;
            var_1898 = param1.var_1898;
            var_2041 = param1.var_2041;
         }
         _color = param2;
         var_4563 = param3;
      }
      
      public function addMask(param1:String, param2:Point, param3:Boolean, param4:Boolean) : void
      {
         var_2119.push(param1);
         var_2024.push(param2);
         var_1898.push(param3);
         var_2041.push(param4);
      }
      
      public function addAssetColumn(param1:Array) : void
      {
         var_770.push(param1);
      }
      
      public function set z(param1:Number) : void
      {
         var_176 = param1;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function set cornerPoints(param1:Vector.<Point>) : void
      {
         var_3439 = param1;
      }
      
      public function get cornerPoints() : Vector.<Point>
      {
         return var_3439;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get maskAssetNames() : Array
      {
         return var_2119;
      }
      
      public function get maskAssetLocations() : Array
      {
         return var_2024;
      }
      
      public function get maskAssetFlipHs() : Array
      {
         return var_1898;
      }
      
      public function get maskAssetFlipVs() : Array
      {
         return var_2041;
      }
      
      public function isBottomAligned() : Boolean
      {
         return var_4563;
      }
      
      public function get assetNameColumns() : Array
      {
         return var_770;
      }
   }
}

