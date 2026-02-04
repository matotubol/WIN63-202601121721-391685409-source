package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import com.sulake.habbo.utils.class_2724;
   import flash.events.EventDispatcher;
   
   public class RandomWalkMovingBackgroundObject extends BackgroundObject
   {
      
      private var var_3587:int;
      
      private var var_3408:int;
      
      private var var_3977:Number;
      
      private var var_4677:Number;
      
      private var var_2494:Number;
      
      private var var_2541:Number;
      
      private var var_3512:Number;
      
      private var var_323:uint = 0;
      
      private var var_1574:Number;
      
      private var var_1589:Number;
      
      private var var_3767:Number = 0;
      
      private var var_3549:Number = 0;
      
      private var var_4673:Number = 0;
      
      private var var_5081:Number = 0;
      
      private var var_3519:uint;
      
      public function RandomWalkMovingBackgroundObject(param1:int, param2:class_1812, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5,false);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         var_3587 = int(_loc7_[2]);
         var_3408 = int(_loc7_[3]);
         var_2494 = Number(_loc7_[4]);
         var_2541 = Number(_loc7_[5]);
         var_3977 = Number(_loc7_[6]);
         var_4677 = Number(_loc7_[7]);
         var_3512 = int(_loc7_[8]);
         var_1574 = var_3587;
         var_1589 = var_3408;
         sprite.assetUri = "${image.library.url}" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         var_323 += param1;
         if(var_323 - var_3519 > var_3512)
         {
            var_4673 = var_3767;
            var_5081 = var_3549;
            var_3767 = (Math.random() * 2 - 1) * var_3977;
            var_3549 = (Math.random() * 2 - 1) * var_4677;
            var_3519 = var_323;
         }
         var _loc4_:int = window.width;
         var _loc2_:int = window.height;
         var _loc3_:Number = (var_323 - var_3519) / var_3512;
         var_1574 += param1 / 1000 * (var_2494 + class_2724.lerp(_loc3_,var_4673,var_3767));
         var_1589 += param1 / 1000 * (var_2541 + class_2724.lerp(_loc3_,var_5081,var_3549));
         sprite.x = var_1574;
         sprite.y = var_1589;
         if(var_2494 > 0 && sprite.x > _loc4_ || var_2494 < 0 && sprite.x + sprite.width < 0 || var_2541 > 0 && sprite.y > _loc2_ || var_2541 < 0 && sprite.y + sprite.height < 0)
         {
            var_1574 = var_3587;
            var_1589 = var_3408;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}

