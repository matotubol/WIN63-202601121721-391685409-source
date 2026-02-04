package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.components.class_2251;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class CalendarSpinnerUtil
   {
      
      public function CalendarSpinnerUtil()
      {
         super();
      }
      
      public static function createGradients(param1:CalendarView, param2:int) : void
      {
         var _loc6_:class_2251 = param1.window.findChildByName("gradient1") as class_2251;
         var _loc7_:int = Math.max(1,param1.calculateItemListWidth(param2) - param1.itemList.scrollH * param1.itemList.maxScrollH);
         var _loc4_:BitmapData = new BitmapData(_loc7_,param1.itemList.height,true,0);
         var _loc5_:Sprite = new Sprite();
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(_loc4_.width,_loc4_.height);
         _loc5_.graphics.beginGradientFill("linear",[987168,987168],[0.6,0.2],[0,255],_loc3_);
         _loc5_.graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         _loc4_.draw(_loc5_);
         _loc6_.bitmap = _loc4_;
         _loc6_ = param1.window.findChildByName("gradient2") as class_2251;
         _loc7_ = Math.max(1,param1.scrollerWidth - (_loc7_ + param1.itemWidth + param1.itemGap));
         _loc4_ = new BitmapData(_loc7_,param1.itemList.height,true,0);
         _loc3_.createGradientBox(_loc4_.width,_loc4_.height);
         _loc5_.graphics.clear();
         _loc5_.graphics.beginGradientFill("linear",[987168,987168],[0.2,0.6],[0,255],_loc3_);
         _loc5_.graphics.drawRect(0,0,_loc4_.width,_loc4_.height);
         _loc4_.draw(_loc5_);
         _loc6_.x = param1.scrollerWidth - _loc7_;
         _loc6_.bitmap = _loc4_;
      }
   }
}

