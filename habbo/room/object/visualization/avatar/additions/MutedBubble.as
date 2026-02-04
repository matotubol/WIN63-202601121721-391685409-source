package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.display.BitmapData;
   
   public class MutedBubble implements class_2504
   {
      
      private var var_197:int = -1;
      
      private var _asset:BitmapDataAsset;
      
      private var var_213:AvatarVisualization;
      
      private var _relativeDepth:Number = 0;
      
      public function MutedBubble(param1:int, param2:AvatarVisualization)
      {
         super();
         var_197 = param1;
         var_213 = param2;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         _relativeDepth = param1;
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
      
      public function animate(param1:IRoomObjectSprite) : Boolean
      {
         if(_asset && param1)
         {
            param1.asset = _asset.content as BitmapData;
         }
         return false;
      }
      
      public function update(param1:IRoomObjectSprite, param2:Number) : void
      {
         if(!param1)
         {
            return;
         }
         param1.visible = true;
         param1.relativeDepth = _relativeDepth;
         param1.alpha = 255;
         if(param2 < 48)
         {
            _asset = var_213.getAvatarRendererAsset("user_muted_small_png") as BitmapDataAsset;
            var _loc3_:int = -12;
            var _loc4_:int = -66;
            var _loc5_:int = 32;
         }
         else
         {
            _asset = var_213.getAvatarRendererAsset("user_muted_png") as BitmapDataAsset;
            _loc3_ = -15;
            _loc4_ = -110;
         }
         if(var_213.posture == "sit")
         {
            _loc4_ = 0 + 64 / 2;
         }
         else if(var_213.posture == "lay")
         {
            _loc4_ = 0 + 64;
         }
         if(_asset != null)
         {
            param1.asset = _asset.content as BitmapData;
            param1.offsetX = 0;
            param1.offsetY = 0;
            param1.relativeDepth = -0.02;
         }
      }
   }
}

