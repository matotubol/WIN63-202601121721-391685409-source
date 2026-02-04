package com.sulake.habbo.friendbar.onBoardingHcSteps
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RandomAvatarCloudsAnimation extends Sprite
   {
      
      private static const cloud_1_1_png:Class = class_4120;
      
      private static const cloud_1_2_png:Class = class_4121;
      
      private static const cloud_1_3_png:Class = class_4122;
      
      private static const cloud_1_4_png:Class = class_4123;
      
      private static const cloud_2_1_png:Class = class_4124;
      
      private static const cloud_2_2_png:Class = class_4125;
      
      private static const cloud_2_3_png:Class = class_4126;
      
      private static const cloud_2_4_png:Class = class_4127;
      
      private static const cloud_3_1_png:Class = c3_1_png$46b02c657bbce715001e1d4686ad3c4d1460401361;
      
      private static const cloud_3_2_png:Class = c3_2_png$9d1d775eb8f0d4b9e5610a5488ea692c1461571410;
      
      private static const cloud_3_3_png:Class = c3_3_png$22b9cf23e5ee97f34a1a8fc83fcfa5c51466705875;
      
      private static const cloud_3_4_png:Class = c3_4_png$6366bc004b859e0a7ee0ffb0f84afa521467891308;
      
      private static const cloud_4_1_png:Class = c4_1_png$044846267c9c41d2c92ab5bd4c7af20136842386;
      
      private static const cloud_4_2_png:Class = c4_2_png$b29213b280e74b70f2a2d1aed3a9998033817107;
      
      private static const cloud_4_3_png:Class = c4_3_png$37f7631b5a666f8f52e2350082d374cc35003052;
      
      private static const cloud_4_4_png:Class = c4_4_png$691508e586c084f583e486e9f9ebfe6c35157293;
      
      private var var_3604:Array;
      
      private var var_3800:Array;
      
      private var _downFrames:Array;
      
      private var var_3816:Array;
      
      private var var_1157:Timer;
      
      private var var_738:int;
      
      private var _animationFrame:int;
      
      private var var_568:Sprite;
      
      private var var_437:Sprite;
      
      private var var_579:Sprite;
      
      private var var_3776:Array = [-9,-8,-5,-3,3,5,8,9];
      
      private var var_3119:int;
      
      public function RandomAvatarCloudsAnimation()
      {
         super();
         var_3800 = [new cloud_1_1_png(),new cloud_1_2_png(),new cloud_1_3_png(),new cloud_1_4_png()];
         var_3604 = [new cloud_2_1_png(),new cloud_2_2_png(),new cloud_2_3_png(),new cloud_2_4_png()];
         _downFrames = [new cloud_3_1_png(),new cloud_3_2_png(),new cloud_3_3_png(),new cloud_3_4_png()];
         var_3816 = [new cloud_4_1_png(),new cloud_4_2_png(),new cloud_4_3_png(),new cloud_4_4_png()];
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function dispose() : void
      {
         if(var_1157)
         {
            var_1157.reset();
            var_1157 = null;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         var_579 = new Sprite();
         addChild(var_579);
         var_568 = new Sprite();
         addChild(var_568);
         var_437 = new Sprite();
         addChild(var_437);
         resetAnimation();
      }
      
      private function resetAnimation() : void
      {
         var_738 = 0;
         _animationFrame = 0;
         var_579.addChild(_downFrames[0]);
         var_579.x = 75;
         var_579.y = 140;
         var_568.addChild(var_3604[0]);
         var_568.x = 30;
         var_568.y = 115;
         var_437.addChild(var_3800[0]);
         var_437.x = 85;
         var_437.y = 110;
         var_579.visible = true;
         var_568.visible = true;
         var_437.visible = true;
      }
      
      public function startAnimation() : void
      {
         resetAnimation();
         if(!var_1157)
         {
            var_1157 = new Timer(80);
            var_1157.addEventListener("timer",onAnimateTimer);
         }
         var _loc1_:int = Math.round(Math.random() * (var_3776.length - 1));
         var_3119 = var_3776[_loc1_];
         var_1157.start();
      }
      
      private function onAnimateTimer(param1:TimerEvent) : void
      {
         if(var_1157 == null)
         {
            return;
         }
         var_738 = var_738 + 1;
         if(var_738 > 2 && var_738 < 5)
         {
            _animationFrame = 1;
         }
         else if(var_738 > 4 && var_738 < 7)
         {
            _animationFrame = 2;
         }
         else if(var_738 > 6 && var_738 < 9)
         {
            _animationFrame = 3;
         }
         else if(var_738 >= 9)
         {
            var_579.visible = false;
            var_568.visible = false;
            var_437.visible = false;
         }
         var_579.removeChildAt(0);
         var_568.removeChildAt(0);
         var_437.removeChildAt(0);
         var_579.addChild(_downFrames[_animationFrame]);
         var_568.addChild(var_3604[_animationFrame]);
         var_437.addChild(var_3800[_animationFrame]);
         var _loc2_:int = Math.round(Math.random() * 10);
         if(_loc2_ % 2 != 0)
         {
            var_437.removeChildAt(0);
            var_437.addChild(var_3816[_animationFrame]);
         }
         else
         {
            var_579.removeChildAt(0);
            var_579.addChild(var_3816[_animationFrame]);
         }
         if(var_738 <= 9)
         {
            var_437.x += 10 + Math.random() * 5;
            var_437.y -= var_3119;
            var_568.x -= 10 + Math.random() * 5;
            var_568.y -= var_3119;
            var_579.y += var_3119 * 1.3;
         }
      }
   }
}

