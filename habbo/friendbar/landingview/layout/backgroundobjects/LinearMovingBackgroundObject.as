package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class LinearMovingBackgroundObject extends BackgroundObject
   {
      
      private var var_3587:int;
      
      private var var_3408:int;
      
      private var var_1574:Number;
      
      private var var_1589:Number;
      
      private var var_2494:Number;
      
      private var var_2541:Number;
      
      public function LinearMovingBackgroundObject(param1:int, param2:class_1812, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         var_3587 = int(_loc7_[2]);
         var_3408 = int(_loc7_[3]);
         var_2494 = Number(_loc7_[4]);
         var_2541 = Number(_loc7_[5]);
         var_1574 = var_3587;
         var_1589 = var_3408;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         var _loc3_:int = window.width;
         var _loc2_:int = window.height;
         var_1574 += param1 * var_2494;
         var_1589 += param1 * var_2541;
         sprite.x = var_1574;
         sprite.y = var_1589 + window.desktop.height;
         if(var_2494 > 0 && sprite.x > _loc3_ || var_2494 < 0 && sprite.x + sprite.width < 0 || var_2541 > 0 && sprite.y > _loc2_ || var_2541 < 0 && sprite.y + sprite.height < 0)
         {
            var_1574 = var_3587;
            var_1589 = var_3408;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}

