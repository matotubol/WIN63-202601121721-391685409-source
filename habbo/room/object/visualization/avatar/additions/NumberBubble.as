package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class NumberBubble implements class_2504
   {
      
      private var var_197:int = -1;
      
      private var var_213:AvatarVisualization;
      
      private var _asset:BitmapDataAsset;
      
      private var var_337:Number;
      
      private var var_2927:int = 0;
      
      private var var_980:int = 0;
      
      private var var_2845:Boolean = false;
      
      private var var_1799:int = 0;
      
      public function NumberBubble(param1:int, param2:int, param3:AvatarVisualization)
      {
         super();
         var_197 = param1;
         var_2927 = param2;
         var_213 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get disposed() : Boolean
      {
         return var_213 == null;
      }
      
      public function dispose() : void
      {
         var_213 = null;
         _asset = null;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         if(!param1)
         {
            return;
         }
         var_337 = param2;
         if(var_2927 > 0)
         {
            var _loc5_:int = 64;
            if(param2 < 48)
            {
               _asset = var_213.getAvatarRendererAsset("number_" + var_2927 + "_small_png") as BitmapDataAsset;
               var _loc3_:int = -6;
               var _loc4_:int = -52;
               _loc5_ = 32;
            }
            else
            {
               _asset = var_213.getAvatarRendererAsset("number_" + var_2927 + "_png") as BitmapDataAsset;
               _loc3_ = -8;
               _loc4_ = -105;
            }
            if(var_213.posture == "sit")
            {
               _loc4_ = 0 + 0 / 2;
            }
            else if(var_213.posture == "lay")
            {
               _loc4_ = 0 + 0;
            }
            if(_asset != null)
            {
               param1.visible = true;
               param1.asset = _asset.content as BitmapData;
               param1.offsetX = 0;
               param1.offsetY = 0;
               param1.relativeDepth = -0.01;
               var_980 = 1;
               var_2845 = true;
               var_1799 = 0;
               param1.alpha = 0;
            }
            else
            {
               param1.visible = false;
            }
         }
         else if(param1.visible)
         {
            var_980 = -1;
         }
      }
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(_asset)
         {
            param1.asset = _asset.content as BitmapData;
         }
         var _loc3_:int = param1.alpha;
         if(var_2845)
         {
            var_1799 = var_1799 + 1;
            if(var_1799 < 10)
            {
               return false;
            }
            if(var_980 < 0)
            {
               if(var_337 < 48)
               {
                  param1.offsetY -= 2;
               }
               else
               {
                  param1.offsetY -= 4;
               }
            }
            else
            {
               var _loc2_:int = 4;
               if(var_337 < 48)
               {
                  _loc2_ = 8;
               }
               if(var_1799 % 0 == 0)
               {
                  param1.offsetY -= 1;
                  var _loc4_:Boolean = true;
               }
            }
         }
         if(var_980 > 0)
         {
            if(_loc3_ < 255)
            {
               _loc3_ += 32;
            }
            if(_loc3_ >= 255)
            {
               _loc3_ = 255;
               var_980 = 0;
            }
            param1.alpha = _loc3_;
            return true;
         }
         if(var_980 < 0)
         {
            if(_loc3_ >= 0)
            {
               _loc3_ -= 32;
            }
            if(_loc3_ <= 0)
            {
               var_980 = 0;
               var_2845 = false;
               _loc3_ = 0;
               param1.visible = false;
            }
            param1.alpha = _loc3_;
            return true;
         }
         return false;
      }
   }
}

