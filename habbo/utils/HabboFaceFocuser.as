package com.sulake.habbo.utils
{
   import com.sulake.habbo.avatar.class_1827;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HabboFaceFocuser
   {
      
      private static const ICON_HEIGHT_NORMAL:int = 50;
      
      private static const ICON_WIDTH_NORMAL:int = 50;
      
      private static const const_37:Array = [-100,-100,21,21,-100,-100,-100,-100,-100];
      
      private static const const_39:Array = [-100,-100,28,30,-100,-100,-100,-100,-100];
      
      public function HabboFaceFocuser()
      {
         super();
      }
      
      public static function focusUserFace(param1:class_1827, param2:String, param3:int, param4:Number, param5:Number = -1, param6:Number = -1) : BitmapData
      {
         var _loc11_:int = 50 * param4;
         var _loc10_:int = 50 * param4;
         if(param5 == -1)
         {
            param5 = _loc11_;
         }
         if(param6 == -1)
         {
            param6 = _loc10_;
         }
         param1.setDirection(param2,param3);
         var _loc9_:BitmapData = param1.getImage(param2,true,param4);
         var _loc12_:Number = (param6 - _loc10_) / 2;
         var _loc7_:BitmapData = new BitmapData(param5,param6,true,0);
         var _loc8_:Rectangle = new Rectangle(const_37[param3] * param4,const_39[param3] * param4,_loc11_,_loc10_);
         _loc7_.copyPixels(_loc9_,_loc8_,new Point(0,_loc12_));
         return _loc7_;
      }
      
      public static function cutCircleFromBitmap(param1:BitmapData, param2:Number) : BitmapData
      {
         var _loc4_:int = param1.width;
         var _loc7_:int = param1.height;
         var _loc3_:BitmapData = new BitmapData(_loc4_,_loc7_,true,0);
         var _loc6_:Shape = new Shape();
         _loc6_.graphics.beginFill(16777215);
         _loc6_.graphics.drawCircle(_loc4_ / 2,_loc7_ / 2,param2);
         _loc6_.graphics.endFill();
         var _loc5_:BitmapData = new BitmapData(_loc4_,_loc7_,true,0);
         _loc5_.draw(_loc6_);
         _loc3_.copyPixels(param1,new Rectangle(0,0,_loc4_,_loc7_),new Point(0,0),_loc5_,new Point(0,0),true);
         return _loc3_;
      }
   }
}

