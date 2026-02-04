package com.sulake.habbo.freeflowchat.viewer.visualization.style
{
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.style.class_2133;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class ChatStyle implements class_2133, class_2134
   {
      
      private var _background:BitmapData;
      
      private var _scale9Grid:Rectangle;
      
      private var var_595:BitmapData;
      
      private var _pointerY:int;
      
      private var _pointerXMargins:Array;
      
      private var var_3877:Rectangle;
      
      private var var_2154:TextFormat;
      
      private var var_952:BitmapData;
      
      private var _iconOffset:Point;
      
      private var var_4703:BitmapData;
      
      private var _color:BitmapData;
      
      private var _colorOffset:Point;
      
      private var _overlap:Rectangle;
      
      private var var_4291:Boolean;
      
      private var var_4880:Boolean;
      
      private var var_5144:Boolean;
      
      private var var_4660:Boolean;
      
      private var var_4479:Boolean;
      
      private var _isAnonymous:Boolean;
      
      private var _allowHTML:Boolean;
      
      private var var_4268:StyleSheet;
      
      private var var_4978:Boolean;
      
      public function ChatStyle(param1:BitmapData, param2:Rectangle, param3:BitmapData, param4:int, param5:Array, param6:Rectangle, param7:TextFormat, param8:Boolean, param9:Point, param10:BitmapData, param11:BitmapData, param12:Boolean, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:BitmapData = null, param19:Point = null, param20:Rectangle = null, param21:Boolean = false, param22:StyleSheet = null)
      {
         super();
         _background = param1;
         _scale9Grid = param2;
         var_595 = param3;
         _pointerY = param4;
         _pointerXMargins = param5;
         var_3877 = param6;
         var_2154 = param7;
         _isAnonymous = param8;
         _iconOffset = param9;
         var_952 = param10;
         var_4703 = param11;
         var_4291 = param12;
         var_4880 = param13;
         var_5144 = param14;
         var_4660 = param16;
         var_4479 = param15;
         _color = param18;
         _colorOffset = param19;
         _overlap = param20;
         _allowHTML = param21;
         var_4268 = param22;
         var_4978 = param17;
      }
      
      public function getNewBackgroundSprite(param1:uint = 16777215) : Sprite
      {
         var _loc4_:BitmapData = null;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         if(_color != null)
         {
            _loc4_ = new BitmapData(_background.width,_background.height,_background.transparent,0);
            _loc4_.copyPixels(_background,_background.rect,new Point(0,0));
            _loc2_ = uint(param1 >> 16 & 0xFF);
            _loc5_ = uint(param1 >> 8 & 0xFF);
            _loc3_ = uint(param1 >> 0 & 0xFF);
            _loc4_.draw(_color,null,new ColorTransform(_loc2_ / 255,_loc5_ / 255,_loc3_ / 255),"darken");
         }
         else
         {
            _loc4_ = _background;
         }
         return HabboFreeFlowChat.create9SliceSprite(_scale9Grid,_loc4_);
      }
      
      public function get textFormat() : TextFormat
      {
         return var_2154;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return var_4268;
      }
      
      public function get pointer() : BitmapData
      {
         return var_595;
      }
      
      public function get pointerOffsetToBubbleBottom() : int
      {
         return _background.height - _pointerY;
      }
      
      public function getPointerLeftMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 1)
         {
            return param1;
         }
         return _pointerXMargins[0];
      }
      
      public function getPointerRightMargin(param1:int) : int
      {
         if(_pointerXMargins == null || _pointerXMargins.length < 2)
         {
            return param1;
         }
         return _pointerXMargins[1];
      }
      
      public function get isAnonymous() : Boolean
      {
         return _isAnonymous;
      }
      
      public function get faceOffset() : Point
      {
         return _iconOffset;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_952;
      }
      
      public function get textFieldMargins() : Rectangle
      {
         return var_3877;
      }
      
      public function get overlap() : Rectangle
      {
         return _overlap;
      }
      
      public function get selectorPreview() : BitmapData
      {
         return var_4703;
      }
      
      public function get isSystemStyle() : Boolean
      {
         return var_4291;
      }
      
      public function get purchasable() : Boolean
      {
         return var_4880;
      }
      
      public function get isHcOnly() : Boolean
      {
         return var_5144;
      }
      
      public function get isAmbassadorOnly() : Boolean
      {
         return var_4660;
      }
      
      public function get isStaffOverrideable() : Boolean
      {
         return var_4479;
      }
      
      public function get allowHTML() : Boolean
      {
         return _allowHTML;
      }
      
      public function get isNotification() : Boolean
      {
         return var_4978;
      }
   }
}

