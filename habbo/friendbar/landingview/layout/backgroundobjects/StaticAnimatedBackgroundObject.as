package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class StaticAnimatedBackgroundObject extends BackgroundObject
   {
      
      private var var_2379:uint = 0;
      
      private var _imageBaseUri:String;
      
      private var var_848:int;
      
      private var _fps:int;
      
      private var var_1574:int;
      
      private var var_1589:int;
      
      private var var_3684:Array;
      
      private var var_4617:uint = 0;
      
      public function StaticAnimatedBackgroundObject(param1:int, param2:class_1812, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc6_:Array = param5.split(";");
         _imageBaseUri = "${image.library.url}reception/" + _loc6_[0];
         var_848 = int(_loc6_[2]);
         _fps = int(_loc6_[3]);
         var_1574 = int(_loc6_[4]);
         var_1589 = int(_loc6_[5]);
         var_3684 = String(_loc6_[6]).split(",");
         param3.addEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET",onPathResetEvent);
         sprite.x = var_1574;
         sprite.y = var_1589;
      }
      
      override public function dispose() : void
      {
         events.removeEventListener("LWMOPRE_MOVING_OBJECT_PATH_RESET",onPathResetEvent);
         super.dispose();
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         var _loc4_:int = 1000 / _fps;
         var _loc2_:uint = var_2379 - var_4617;
         var _loc3_:int = var_848 - 1;
         if(var_3684.length > 0)
         {
            if(_loc2_ < var_848 * _loc4_)
            {
               _loc3_ = _loc2_ / _loc4_;
            }
         }
         else
         {
            _loc3_ = var_2379 % _loc4_;
         }
         sprite.assetUri = _imageBaseUri + (_loc3_ + 1) + ".png";
         var_2379 += param1;
      }
      
      private function onPathResetEvent(param1:PathResetEvent) : void
      {
         if(var_3684.indexOf(param1.objectId.toString()) != -1)
         {
            var_4617 = var_2379;
         }
      }
   }
}

