package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   
   public class PlaneMaskBitmap
   {
      
      public static const const_21:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _asset:IGraphicAsset = null;
      
      private var var_3819:Number = -1;
      
      private var var_4079:Number = 1;
      
      private var var_4381:Number = -1;
      
      private var var_3994:Number = 1;
      
      public function PlaneMaskBitmap(param1:IGraphicAsset, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1)
      {
         super();
         var_3819 = param2;
         var_4079 = param3;
         var_4381 = param4;
         var_3994 = param5;
         _asset = param1;
      }
      
      public function get asset() : IGraphicAsset
      {
         return _asset;
      }
      
      public function get normalMinX() : Number
      {
         return var_3819;
      }
      
      public function get normalMaxX() : Number
      {
         return var_4079;
      }
      
      public function get normalMinY() : Number
      {
         return var_4381;
      }
      
      public function get normalMaxY() : Number
      {
         return var_3994;
      }
      
      public function dispose() : void
      {
         _asset = null;
      }
   }
}

