package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.class_2134;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class BlankStyle implements class_2134
   {
      
      public function BlankStyle()
      {
         super();
      }
      
      public function getNewBackgroundSprite(param1:uint = 16777215) : Sprite
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.clear();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,20,19 + 10);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      public function get textFormat() : TextFormat
      {
         return new TextFormat();
      }
      
      public function get styleSheet() : StyleSheet
      {
         return null;
      }
      
      public function get pointer() : BitmapData
      {
         return new BitmapData(1,10,true,0);
      }
      
      public function get pointerOffsetToBubbleBottom() : int
      {
         return 19;
      }
      
      public function getPointerLeftMargin(param1:int) : int
      {
         return param1;
      }
      
      public function getPointerRightMargin(param1:int) : int
      {
         return param1;
      }
      
      public function get faceOffset() : Point
      {
         return null;
      }
      
      public function get isAnonymous() : Boolean
      {
         return true;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return true;
      }
      
      public function get textFieldMargins() : Rectangle
      {
         return new Rectangle(0,0,0,0);
      }
      
      public function get overlap() : Rectangle
      {
         return new Rectangle(0,0,0,0);
      }
      
      public function get allowHTML() : Boolean
      {
         return false;
      }
      
      public function get isNotification() : Boolean
      {
         return false;
      }
   }
}

