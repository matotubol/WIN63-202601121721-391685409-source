package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_2314;
   import com.sulake.habbo.avatar.animation.class_2792;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public interface class_1827 extends class_13
   {
      
      function getCroppedImage(param1:String, param2:Number = 1) : BitmapData;
      
      function getHeadRegPoints(param1:String) : Point;
      
      function getFaceOffset(param1:String) : Point;
      
      function getImage(param1:String, param2:Boolean, param3:Number = 1) : BitmapData;
      
      function getServerRenderData() : Array;
      
      function setDirection(param1:String, param2:int) : void;
      
      function setDirectionAngle(param1:String, param2:int) : void;
      
      function updateAnimationByFrames(param1:int = 1) : void;
      
      function getScale() : String;
      
      function getSprites() : Vector.<ISpriteDataContainer>;
      
      function getLayerData(param1:ISpriteDataContainer) : class_2314;
      
      function getAsset(param1:String) : BitmapDataAsset;
      
      function getDirection() : int;
      
      function getFigure() : class_1900;
      
      function getPartColor(param1:String) : IPartColor;
      
      function isAnimating() : Boolean;
      
      function getCanvasOffsets() : Array;
      
      function initActionAppends() : void;
      
      function endActionAppends() : void;
      
      function appendAction(param1:String, ... rest) : Boolean;
      
      function get avatarSpriteData() : class_2792;
      
      function isPlaceholder() : Boolean;
      
      function isBlocked() : Boolean;
      
      function forceActionUpdate() : void;
      
      function get animationHasResetOnToggle() : Boolean;
      
      function resetAnimationFrameCounter() : void;
      
      function get mainAction() : String;
      
      function disposeInactiveActionCache() : void;
   }
}

