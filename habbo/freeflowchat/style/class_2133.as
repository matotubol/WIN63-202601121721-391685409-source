package com.sulake.habbo.freeflowchat.style
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   
   public interface class_2133
   {
      
      function get selectorPreview() : BitmapData;
      
      function get isSystemStyle() : Boolean;
      
      function get purchasable() : Boolean;
      
      function get isHcOnly() : Boolean;
      
      function get isAmbassadorOnly() : Boolean;
      
      function get isStaffOverrideable() : Boolean;
      
      function getNewBackgroundSprite(param1:uint = 16777215) : Sprite;
      
      function get overlap() : Rectangle;
      
      function get textFormat() : TextFormat;
   }
}

