package com.sulake.habbo.utils
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class class_2495
   {
      
      public function class_2495()
      {
         super();
      }
      
      private static function resizeBitmapData(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(Math.round(param1.width * param2),Math.round(param1.height * param2),true,16777215);
         var _loc4_:Matrix = new Matrix(_loc3_.width / param1.width,0,0,_loc3_.height / param1.height,0,0);
         _loc3_.draw(param1,_loc4_,null,null,null,true);
         return _loc3_;
      }
      
      public static function resampleBitmapData(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc3_:BitmapData = null;
         var _loc4_:Number = NaN;
         if(param2 >= 1)
         {
            return resizeBitmapData(param1,param2);
         }
         _loc3_ = param1.clone();
         _loc4_ = 1;
         do
         {
            if(param2 < 0.5 * _loc4_)
            {
               _loc3_ = resizeBitmapData(_loc3_,0.5);
               _loc4_ = 0.5 * _loc4_;
            }
            else
            {
               _loc3_ = resizeBitmapData(_loc3_,param2 / _loc4_);
               _loc4_ = param2;
            }
         }
         while(_loc4_ != param2);
         
         return _loc3_;
      }
   }
}

