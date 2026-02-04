package com.sulake.room.renderer
{
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public interface IRoomRenderingCanvas
   {
      
      function set useMask(param1:Boolean) : void;
      
      function initialize(param1:int, param2:int) : void;
      
      function get width() : int;
      
      function get height() : int;
      
      function set screenOffsetX(param1:int) : void;
      
      function set screenOffsetY(param1:int) : void;
      
      function get screenOffsetX() : int;
      
      function get screenOffsetY() : int;
      
      function render(param1:int, param2:Boolean = false) : void;
      
      function get displayObject() : DisplayObject;
      
      function get geometry() : IRoomGeometry;
      
      function set fpsCounterEnabled(param1:Boolean) : void;
      
      function set mouseListener(param1:IRoomRenderingCanvasMouseListener) : void;
      
      function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean;
      
      function getSortableSpriteList() : Vector.<RoomObjectSpriteData>;
      
      function getPlaneSortableSprites() : Array;
      
      function setScale(param1:Number, param2:Point = null, param3:Point = null, param4:Boolean = false) : void;
      
      function get scale() : Number;
      
      function takeScreenShot() : BitmapData;
      
      function skipSpriteVisibilityChecking() : void;
      
      function resumeSpriteVisibilityChecking() : void;
      
      function getId() : int;
   }
}

