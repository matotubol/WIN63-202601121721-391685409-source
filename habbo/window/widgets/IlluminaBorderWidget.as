package com.sulake.habbo.window.widgets
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class IlluminaBorderWidget implements IIlluminaBorderWidget
   {
      
      public static const TYPE:String = "illumina_border";
      
      public static const BORDER_STYLE_ILLUMINA_LIGHT:String = "illumina_light";
      
      public static const BORDER_STYLE_ILLUMINA_DARK:String = "illumina_dark";
      
      public static const BORDER_STYLE_KEY:String = "illumina_border:border_style";
      
      private static const CONTENT_CHILD_KEY:String = "illumina_border:content_child";
      
      private static const CONTENT_PADDING_KEY:String = "illumina_border:content_padding";
      
      private static const SIDE_PADDING_KEY:String = "illumina_border:side_padding";
      
      private static const CHILD_MARGIN_KEY:String = "illumina_border:child_margin";
      
      private static const TOP_LEFT_CHILD_KEY:String = "illumina_border:top_left_child";
      
      private static const TOP_CENTER_CHILD_KEY:String = "illumina_border:top_center_child";
      
      private static const TOP_RIGHT_CHILD_KEY:String = "illumina_border:top_right_child";
      
      private static const BOTTOM_LEFT_CHILD_KEY:String = "illumina_border:bottom_left_child";
      
      private static const BOTTOM_CENTER_CHILD_KEY:String = "illumina_border:bottom_center_child";
      
      private static const BOTTOM_RIGHT_CHILD_KEY:String = "illumina_border:bottom_right_child";
      
      private static const LANDING_VIEW_MODE_KEY:String = "illumina_border:landing_view_mode";
      
      private static const TOP_LEFT:String = "top_left";
      
      private static const TOP:String = "top_center";
      
      private static const TOP_RIGHT:String = "top_right";
      
      private static const RIGHT:String = "center_right";
      
      private static const BOTTOM_RIGHT:String = "bottom_right";
      
      private static const BOTTOM:String = "bottom_center";
      
      private static const BOTTOM_LEFT:String = "bottom_left";
      
      private static const const_47:String = "center_left";
      
      public static const BORDER_STYLES:Array = ["illumina_light","illumina_dark"];
      
      private static const CONTENT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_child","","String");
      
      private static const CONTENT_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:content_padding",5,"uint");
      
      private static const SIDE_PADDING_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:side_padding",15,"uint");
      
      private static const CHILD_MARGIN_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:child_margin",3,"uint");
      
      private static const TOP_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_left_child","","String");
      
      private static const TOP_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_center_child","","String");
      
      private static const TOP_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:top_right_child","","String");
      
      private static const BOTTOM_LEFT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_left_child","","String");
      
      private static const BOTTOM_CENTER_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_center_child","","String");
      
      private static const BOTTOM_RIGHT_CHILD_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:bottom_right_child","","String");
      
      private static const LANDING_VIEW_MODE_DEFAULT:PropertyStruct = new PropertyStruct("illumina_border:landing_view_mode",false,"Boolean");
      
      private static const MATRIX:Matrix = new Matrix();
      
      private static const BORDER_PIECES:Array = ["top_left","top_center","top_right","center_right","bottom_right","bottom_center","bottom_left","center_left"];
      
      private var var_1892:Dictionary;
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var var_110:class_2251;
      
      private var var_342:BitmapData;
      
      private var _children:class_1812;
      
      private var var_2758:Boolean = false;
      
      private var var_669:Boolean = false;
      
      private var var_2833:String;
      
      private var var_1505:String = String(CONTENT_CHILD_DEFAULT.value);
      
      private var var_1568:uint = uint(CONTENT_PADDING_DEFAULT.value);
      
      private var var_1501:uint = uint(SIDE_PADDING_DEFAULT.value);
      
      private var _childMargin:uint = uint(CHILD_MARGIN_DEFAULT.value);
      
      private var var_1615:String = String(TOP_LEFT_CHILD_DEFAULT.value);
      
      private var var_1725:String = String(TOP_CENTER_CHILD_DEFAULT.value);
      
      private var var_1586:String = String(TOP_RIGHT_CHILD_DEFAULT.value);
      
      private var var_1666:String = String(BOTTOM_LEFT_CHILD_DEFAULT.value);
      
      private var var_1764:String = String(BOTTOM_CENTER_CHILD_DEFAULT.value);
      
      private var var_1514:String = String(BOTTOM_RIGHT_CHILD_DEFAULT.value);
      
      private var var_1636:Boolean = Boolean(LANDING_VIEW_MODE_DEFAULT.value);
      
      public function IlluminaBorderWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("illumina_border_xml").content as XML) as class_1812;
         var_110 = var_134.getChildByName("canvas") as class_2251;
         _children = var_134.getChildByName("children") as class_1812;
         borderStyle = String(var_210.getDefaultProperty("illumina_border:border_style").value);
         var_210.addEventListener("WE_RESIZE",onChange);
         var_210.addEventListener("WE_RESIZED",onChange);
         _children.addEventListener("WE_CHILD_ADDED",onChange);
         _children.addEventListener("WE_CHILD_REMOVED",onChange);
         _children.addEventListener("WE_CHILD_RELOCATED",onChange);
         _children.addEventListener("WE_CHILD_RESIZED",onChange);
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      private function onChange(param1:class_1758) : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_342 != null)
            {
               var_342.dispose();
               var_342 = null;
            }
            if(var_110 != null)
            {
               var_110.removeEventListener("WE_RESIZE",onChange);
               var_110.removeEventListener("WE_RESIZED",onChange);
               var_110 = null;
            }
            if(_children != null)
            {
               _children.removeEventListener("WE_CHILD_ADDED",onChange);
               _children.removeEventListener("WE_CHILD_REMOVED",onChange);
               _children.removeEventListener("WE_CHILD_RELOCATED",onChange);
               _children.removeEventListener("WE_CHILD_RESIZED",onChange);
               _children = null;
            }
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            var_1892 = null;
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return _children.iterator;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(var_210.createProperty("illumina_border:border_style",var_2833));
         _loc1_.push(CONTENT_CHILD_DEFAULT.withValue(var_1505));
         _loc1_.push(CONTENT_PADDING_DEFAULT.withValue(var_1568));
         _loc1_.push(SIDE_PADDING_DEFAULT.withValue(var_1501));
         _loc1_.push(CHILD_MARGIN_DEFAULT.withValue(_childMargin));
         _loc1_.push(TOP_LEFT_CHILD_DEFAULT.withValue(var_1615));
         _loc1_.push(TOP_CENTER_CHILD_DEFAULT.withValue(var_1725));
         _loc1_.push(TOP_RIGHT_CHILD_DEFAULT.withValue(var_1586));
         _loc1_.push(BOTTOM_LEFT_CHILD_DEFAULT.withValue(var_1666));
         _loc1_.push(BOTTOM_CENTER_CHILD_DEFAULT.withValue(var_1764));
         _loc1_.push(BOTTOM_RIGHT_CHILD_DEFAULT.withValue(var_1514));
         _loc1_.push(LANDING_VIEW_MODE_DEFAULT.withValue(var_1636));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         if(_disposed)
         {
            return;
         }
         var_2758 = true;
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "illumina_border:border_style":
                  borderStyle = String(_loc2_.value);
                  break;
               case "illumina_border:content_child":
                  contentChild = String(_loc2_.value);
                  break;
               case "illumina_border:content_padding":
                  contentPadding = uint(_loc2_.value);
                  break;
               case "illumina_border:side_padding":
                  sidePadding = uint(_loc2_.value);
                  break;
               case "illumina_border:child_margin":
                  childMargin = uint(_loc2_.value);
                  break;
               case "illumina_border:top_left_child":
                  topLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_center_child":
                  topCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:top_right_child":
                  topRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_left_child":
                  bottomLeftChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_center_child":
                  bottomCenterChild = String(_loc2_.value);
                  break;
               case "illumina_border:bottom_right_child":
                  bottomRightChild = String(_loc2_.value);
                  break;
               case "illumina_border:landing_view_mode":
                  landingViewMode = Boolean(_loc2_.value);
            }
         }
         var_2758 = false;
         refresh();
      }
      
      public function get borderStyle() : String
      {
         return var_2833;
      }
      
      public function set borderStyle(param1:String) : void
      {
         var_2833 = param1;
         var_1892 = new Dictionary();
         for each(var _loc2_ in BORDER_PIECES)
         {
            var_1892[_loc2_] = _windowManager.assets.getAssetByName(var_2833 + "_border_" + _loc2_);
         }
         refresh();
      }
      
      public function get contentChild() : String
      {
         return var_1505;
      }
      
      public function set contentChild(param1:String) : void
      {
         var_1505 = param1 ?? "";
         refresh();
      }
      
      public function get contentPadding() : uint
      {
         return var_1568;
      }
      
      public function set contentPadding(param1:uint) : void
      {
         var_1568 = param1;
         refresh();
      }
      
      public function get sidePadding() : uint
      {
         return var_1501;
      }
      
      public function set sidePadding(param1:uint) : void
      {
         var_1501 = param1;
         refresh();
      }
      
      public function get childMargin() : uint
      {
         return _childMargin;
      }
      
      public function set childMargin(param1:uint) : void
      {
         _childMargin = param1;
         refresh();
      }
      
      public function get topLeftChild() : String
      {
         return var_1615;
      }
      
      public function set topLeftChild(param1:String) : void
      {
         var_1615 = param1 ?? "";
         refresh();
      }
      
      public function get topCenterChild() : String
      {
         return var_1725;
      }
      
      public function set topCenterChild(param1:String) : void
      {
         var_1725 = param1 ?? "";
         refresh();
      }
      
      public function get topRightChild() : String
      {
         return var_1586;
      }
      
      public function set topRightChild(param1:String) : void
      {
         var_1586 = param1 ?? "";
         refresh();
      }
      
      public function get bottomLeftChild() : String
      {
         return var_1666;
      }
      
      public function set bottomLeftChild(param1:String) : void
      {
         var_1666 = param1 ?? "";
         refresh();
      }
      
      public function get bottomCenterChild() : String
      {
         return var_1764;
      }
      
      public function set bottomCenterChild(param1:String) : void
      {
         var_1764 = param1 ?? "";
         refresh();
      }
      
      public function get bottomRightChild() : String
      {
         return var_1514;
      }
      
      public function set bottomRightChild(param1:String) : void
      {
         var_1514 = param1 ?? "";
         refresh();
      }
      
      public function get landingViewMode() : Boolean
      {
         return var_1636;
      }
      
      public function set landingViewMode(param1:Boolean) : void
      {
         var_1636 = param1;
         refresh();
      }
      
      private function getPiece(param1:String) : BitmapDataAsset
      {
         return var_1892[param1];
      }
      
      private function getChildHeight(param1:String) : int
      {
         var _loc2_:class_1741 = _children.getChildByName(param1);
         return param1 != null && param1.length > 0 && _loc2_ != null ? _loc2_.height : 0;
      }
      
      private function get topPadding() : int
      {
         return Math.max(getChildHeight(var_1725),Math.max(getChildHeight(var_1615),getChildHeight(var_1586))) / 2;
      }
      
      private function get bottomPadding() : int
      {
         return Math.max(getChildHeight(var_1764),Math.max(getChildHeight(var_1666),getChildHeight(var_1514))) / 2;
      }
      
      private function refresh() : void
      {
         if(var_2758 || var_669 || disposed)
         {
            return;
         }
         var_134.limits.setEmpty();
         var_134.width = var_210.width;
         var_134.height = var_210.height;
         var _loc2_:class_1741 = _children.getChildByName(var_1505);
         if(_loc2_ != null)
         {
            var _loc3_:int = Math.max(1,_loc2_.width + 2 * var_1568);
            var _loc9_:int = Math.max(1,_loc2_.height + 2 * var_1568 + topPadding + bottomPadding);
            var_669 = true;
            if(var_210.testParamFlag(131072))
            {
               var_134.limits.minWidth = 0;
               var_134.limits.minHeight = 0;
            }
            if(var_210.testParamFlag(147456))
            {
               var_134.limits.minWidth = 0;
               var_134.limits.minHeight = 0;
               var_134.limits.maxWidth = 0;
               var_134.limits.maxHeight = 0;
            }
            var_669 = false;
         }
         if(var_342 == null || var_342.width != var_134.width || var_342.height != var_134.height)
         {
            var_110.width = var_134.width;
            var_110.height = var_134.height;
            _children.width = var_134.width;
            _children.height = var_134.height;
            if(var_342 != null)
            {
               var_342.dispose();
            }
            var_342 = new BitmapData(var_110.width,var_110.height,true,0);
            var_110.bitmap = var_342;
         }
         var _loc12_:Rectangle = var_110.rectangle;
         _loc12_.y = _loc12_.y + topPadding;
         _loc12_.height -= topPadding + bottomPadding;
         var_342.lock();
         var_342.fillRect(new Rectangle(0,0,var_110.width,var_110.height),0);
         for(var _loc5_ in var_1892)
         {
            var _loc10_:BitmapDataAsset = getPiece(_loc5_);
            if(!(_loc10_ == null || var_1636 && (_loc5_ == "top_left" || _loc5_ == "center_left" || _loc5_ == "bottom_left")))
            {
               var _loc6_:BitmapData = null.content as BitmapData;
               var _loc13_:Rectangle = null.rectangle;
               var _loc4_:Rectangle = new Rectangle(_loc12_.x,_loc12_.y,null.width,null.height);
               switch(_loc5_)
               {
                  case "top_center":
                     null.x += getPiece("top_left").rectangle.width;
                     null.width = _loc12_.width - getPiece("top_left").rectangle.width - getPiece("top_right").rectangle.width;
                     break;
                  case "top_right":
                     null.x += _loc12_.width - null.width;
                     break;
                  case "center_right":
                     null.x += _loc12_.width - null.width;
                     null.y += getPiece("top_right").rectangle.height;
                     null.height = _loc12_.height - getPiece("top_right").rectangle.height - getPiece("bottom_right").rectangle.height;
                     break;
                  case "bottom_right":
                     null.x += _loc12_.width - null.width;
                     null.y += _loc12_.height - null.height;
                     break;
                  case "bottom_center":
                     null.x += getPiece("bottom_left").rectangle.width;
                     null.y += _loc12_.height - null.height;
                     null.width = _loc12_.width - getPiece("bottom_left").rectangle.width - getPiece("bottom_right").rectangle.width;
                     if(var_1636)
                     {
                        var _loc1_:int = null.width / 2;
                        null.x += 0;
                        null.width -= 0;
                     }
                     break;
                  case "bottom_left":
                     null.y += _loc12_.height - null.height;
                     break;
                  case "center_left":
                     null.y += getPiece("top_left").rectangle.height;
                     null.height = _loc12_.height - getPiece("top_left").rectangle.height - getPiece("bottom_left").rectangle.height;
                     break;
                  case "top_left":
                     break;
                  default:
                     continue;
               }
               MATRIX.a = null.width / null.width;
               MATRIX.d = null.height / null.height;
               MATRIX.tx = null.x - null.x * MATRIX.a;
               MATRIX.ty = null.y - null.y * MATRIX.d;
               var_342.draw(null,MATRIX,null,null,null,false);
            }
         }
         var _loc11_:Array = [var_1615,var_1725,var_1586,var_1666,var_1764,var_1514];
         for each(var _loc7_ in _children.iterator)
         {
            if(_loc7_.name != null && _loc7_.name.length > 0)
            {
               var _loc8_:int = int(_loc11_.indexOf(_loc7_.name));
               if(_loc8_ < 0)
               {
                  if(_loc7_.name == var_1505)
                  {
                     _loc7_.x = _loc12_.x + contentPadding;
                     _loc7_.y = _loc12_.y + contentPadding;
                     _loc7_.visible = true;
                  }
                  else
                  {
                     _loc7_.visible = false;
                  }
               }
               else
               {
                  switch(0 % 3)
                  {
                     case 0:
                        _loc7_.x = Math.min(var_1501,var_110.width - _loc7_.width);
                        break;
                     case 1:
                        _loc7_.x = Math.max(var_110.width - _loc7_.width,0) / 2;
                        break;
                     case 2:
                        _loc7_.x = Math.max(var_110.width - _loc7_.width - var_1501,0);
                  }
                  _loc7_.y = topPadding - _loc7_.height / 2;
                  _loc7_.visible = true;
                  var_342.fillRect(new Rectangle(_loc7_.x - _childMargin,_loc7_.y,_loc7_.width + _childMargin * 2,_loc7_.height),0);
               }
            }
            else
            {
               _loc7_.visible = false;
            }
         }
         var_342.unlock();
         var_110.invalidate();
      }
   }
}

